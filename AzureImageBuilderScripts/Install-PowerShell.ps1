#Download powershell
$Filename = "powershell7.msi"
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.3.3/PowerShell-7.3.3-win-x64.msi" -OutFile $Filename

#Install powershell silently
Start-Process msiexec.exe -Wait -ArgumentList '/package $Filename /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1'

#Remove install file
Remove-Item $Filename