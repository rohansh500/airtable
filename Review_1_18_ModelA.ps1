# Ensure the script is run with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    Write-Warning "Please run this script as an Administrator!"
    Break
}

# Create a Windows Update session
$UpdateSession = New-Object -ComObject Microsoft.Update.Session

# Create an Update Searcher
$UpdateSearcher = $UpdateSession.CreateUpdateSearcher()

Write-Host "Searching for updates..." -ForegroundColor Yellow

# Search for all available updates
$SearchResult = $UpdateSearcher.Search("IsInstalled=0 and Type='Software' and IsHidden=0")

# Check if updates are available
if ($SearchResult.Updates.Count -eq 0) {
    Write-Host "No updates available." -ForegroundColor Green
    Exit
}

Write-Host "Found $($SearchResult.Updates.Count) update(s)." -ForegroundColor Yellow

# Create an Update Collection to store updates
$UpdatesToDownload = New-Object -ComObject Microsoft.Update.UpdateColl

# Add all updates to the collection
foreach ($Update in $SearchResult.Updates) {
    $UpdatesToDownload.Add($Update) | Out-Null
    Write-Host "Added update to download list: $($Update.Title)" -ForegroundColor Cyan
}

# Create a Downloader
$Downloader = $UpdateSession.CreateUpdateDownloader()
$Downloader.Updates = $UpdatesToDownload

Write-Host "Downloading updates..." -ForegroundColor Yellow

# Download the updates
try {
    $DownloadResult = $Downloader.Download()
    
    if ($DownloadResult.ResultCode -eq 2) {
        Write-Host "All updates downloaded successfully." -ForegroundColor Green
    } else {
        Write-Host "Some updates failed to download. Check Windows Update for more information." -ForegroundColor Red
    }
} catch {
    Write-Host "An error occurred during download: $_" -ForegroundColor Red
}

Write-Host "Script completed." -ForegroundColor Gree