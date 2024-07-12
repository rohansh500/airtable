# Check for updates
$updates = Get-WUList -MicrosoftUpdate -Verbose

# Display available updates
Write-Host "Available updates:"
$updates | Format-Table Title, KBArticleID

# Download updates
Write-Host "Downloading updates..."
$downloadResult = $updates | Download-WUPackage -Verbose

# Check download results
if ($downloadResult.Success) {
    Write-Host "Updates downloaded successfully."
} else {
    Write-Host "Error downloading updates."
    $downloadResult | Where-Object {$_.Success -eq $false} | Format-Table Title, Result
}