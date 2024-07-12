# Model A Script

# Check if the script is running in Windows PowerShell
if ($PSVersionTable.PSVersion.Major -ge 6) {
    Write-Warning "This script should be run in Windows PowerShell, not PowerShell Core."
    exit
}

# 1. Use Windows PowerShell Instead of PowerShell Core
Write-Host "Updating Help for DISM module in Windows PowerShell..."
Update-Help -Module DISM -Force

# 2. Use the DISM Command-Line Tool to Update Help
Write-Host "Refreshing DISM help content using the command-line tool..."
DISM /Online /Get-Features /Format:Table

# 3. Manually Download and Install the Help Content
Write-Host "Manual download and installation of help content (follow instructions in the script comments)."
# Go to the Microsoft Download Center and search for "Windows PowerShell Help Files."
# Download the appropriate help files for your Windows version and language.
# Extract the files and copy them to the correct help location (usually C:\Windows\System32\WindowsPowerShell\v1.0\en-US for English).

# 4. Use Online Help as an Alternative
Write-Host "Using online help for DISM module..."
Get-Help DISM -Online

# 5. Check for Windows Updates
Write-Host "Checking for Windows updates..."
# Make sure your system is up to date by checking for updates.

# 6. Rebuild the Help Catalog
Write-Host "Rebuilding the help catalog..."
Remove-Item $pshome\en-US\*.helpinfo -Force
Update-Help

Write-Host "Script completed."
