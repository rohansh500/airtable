# Model B Script

# Causes of the Error: Missing or Incorrect HelpInfoURI, Firewall or Security Software issues

# 1. Use Get-Help with Local Help
Write-Host "Accessing local help for DISM module..."
Get-Help Dism
Get-Help Dism -Name Get-WindowsImage

# 2. Save Help Content from a Connected Machine (Workaround)
Write-Host "Saving help content from a connected machine (if available)."
# If you have another Windows 11 machine with internet access and the DISM help updates successfully,
# you can copy the help files to your offline machine.
# Location: The help files are usually located in a directory like C:\Windows\Help\en-US\Dism
# Copy and Register: Copy this "Dism" folder to the same location on your offline machine.
# Then, you might need to update the help index using:
Update-Help -Force -Module Dism

# 3. Check Firewall/Security Software
Write-Host "Checking firewall/security software settings..."
# Temporarily disable your firewall or security software and try Update-Help again.
# If it works, configure your security software to allow connections to the Microsoft help servers.

Write-Host "Script completed."
