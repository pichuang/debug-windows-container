FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL description="Debug Container for Windows node"

# Install Chocolatey CLI
# https://docs.chocolatey.org/en-us/choco/setup/#requirements
RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Install  Windows Assessment and Deployment Kit (Windows ADK) for Windows Performance Recorder (WPR)
RUN powershell.exe -Command \
    $ErrorActionPreference = 'Stop'; \
    Invoke-WebRequest "https://go.microsoft.com/fwlink/?linkid=2271337" -OutFile c:\Temp\adksetup.exe ; \
    Start-Process c:\Temp\adksetup.exe /quiet /installpath c:\adk -Wait ; \
    Remove-Item c:\Temp\adksetup.exe -Force

ENTRYPOINT [ "powershell", "-Command", "Start-Sleep", "2147483" ]
