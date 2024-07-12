# Define a function to check and install Windows Updates
function Check-And-InstallWindowsUpdates {
    # Import the Update session module
    Write-Output "Creating Update session."
    $UpdateSession = New-Object -ComObject Microsoft.Update.Session
    
    # Create an Update searcher object to find available updates
    Write-Output "Searching for updates."
    $UpdateSearcher = $UpdateSession.CreateUpdateSearcher()
    $UpdatesToDownload = $UpdateSearcher.Search("IsInstalled=0").Updates

    # Check if there are any updates to download
    if ($UpdatesToDownload.Count -eq 0) {
        Write-Output "No updates available."
        return
    }

    # Display available updates
    Write-Output "Updates found:"
    for ($i = 0; $i -lt $UpdatesToDownload.Count; $i++) {
        $Update = $UpdatesToDownload.Item($i)
        Write-Output "$($i+1): $($Update.Title)"
    }

    # Create an Update downloader object to download the updates
    Write-Output "Initializing Update downloader."
    $UpdateDownloader = $UpdateSession.CreateUpdateDownloader()
    
    # Add updates to be downloaded to the download list
    $UpdateCollection = New-Object -ComObject Microsoft.Update.UpdateColl
    foreach ($Update in $UpdatesToDownload) {
        $UpdateCollection.Add($Update)
    }

    # Assign the collection of updates to the downloader
    $UpdateDownloader.Updates = $UpdateCollection

    # Download the updates
    Write-Output "Downloading updates."
    $DownloadResult = $UpdateDownloader.Download()

    # Check the result of the download
    if ($DownloadResult.ResultCode -ne 2) {
        Write-Error "Some updates could not be downloaded."
    } else {
        Write-Output "All updates downloaded successfully."
    }
}

# Run the function
Check-And-InstallWindowsUpdates