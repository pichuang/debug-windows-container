Install-WindowsFeature -name Web-Server -IncludeManagementTools
Get-WindowsFeature -name Web-Server
Get-Service -Name W3SVC
