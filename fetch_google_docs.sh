#!/bin/bash

gdrive_export() {
  destination=$1
  type=$2
  mime=$3
  token=$4
  file=$5
  file_id=$(cat "${file}" | grep "doc_id" | awk -F'"' '{print $4}')
  echo "Downloading TYPE:${type} FILE:'$file' ID:$file_id"
  url="https://www.googleapis.com/drive/v3/files/${file_id}/export?mimeType=application/${mime}"
  curl $url -s --create-dirs --header "Authorization: Bearer ${token}" --header 'Accept: application/json' --compressed -o "${destination}/${file}.${type}"
}
export -f gdrive_export

if [ -z $(type -P curl) ]; then 
  echo "This script requires curl. Please install curl and try again."; 
  exit
fi

if [ "$#" -ne 3 ]; then
  echo "This command requires two arguments:"
  echo "1. Directory to scan and backup"
  echo "2. Directory to download the files into"
  echo "3. Google OAuth 2.0 Token"
  echo "e.g.: ./export_google_drive_files.sh google_drive exportedGoogleDriveFiles my_secret_and_temporary_access_token"
  echo "See https://andrey.mikhalchuk.com/2021/09/05/how-to-backup-google-drives-gdoc-gsheet-files.html for details"
  exit
fi

export token=$3
export destination=$2
export source=$1

# feel free to add support for more formats:
find $source -name "*.gdoc"    -exec bash -c 'gdrive_export "${destination}" docx vnd.openxmlformats-officedocument.wordprocessingml.document   "${token}" "$@"' bash {} \;
find $source -name "*.gsheet"  -exec bash -c 'gdrive_export "${destination}" xlsx vnd.openxmlformats-officedocument.spreadsheetml.sheet         "${token}" "$@"' bash {} \;
find $source -name "*.gslides" -exec bash -c 'gdrive_export "${destination}" pptx vnd.openxmlformats-officedocument.presentationml.presentation "${token}" "$@"' bash {} \;
