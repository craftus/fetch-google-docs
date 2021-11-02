# fetch-google-docs
A simple script fetching the actual content of documents stored on Google Drive.

# Installation
`git clone https://github.com/craftus/fetch-google-docs.git`
Alternatively, you can just copypaste it from Github, it's just a single bash script.

# Use
Make sure that the file is executable: `chmod +x fetch_google_docs.sh`.  
Now you can run it like this:
`fetch_google_docs.sh <GoogleDriveDir> <DownloadDir> <GoogleDriveApiToken>`

This will scan the <GoogleDriveDir> for all .gdoc, .gsheet and .gslides files and 
download their exported versions into the <DownloadDir>.

You can find more information about the script and detailed step-by-step instructions 
for obtaining the <GoogleDriveApiToken> here: https://andrey.mikhalchuk.com/2021/07/05/how-to-actually-backup-google-drives-gdoc-gsheet-gslides-files.html
