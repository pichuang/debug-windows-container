FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL org.opencontainers.image.title = "Debug Container for Windows" \
      org.opencontainers.image.authors = "Phil Huang <phil.huang@microsoft.com>" \
      org.opencontainers.image.source = "https://github.com/pichuang/debug-windows-container" \
      org.opencontainers.image.description = "Debug Container for Windows node" \
      org.opencontainers.image.vendor = "divecode.in" \
      org.opencontainers.image.url = "ghcr.io/pichuang/debug-windows-container:master" \
      org.opencontainers.image.documentation = "https://github.com/pichuang/debug-windows-container"

# Install Chocolatey CLI
# https://docs.chocolatey.org/en-us/choco/setup/#requirements
RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN powershell.exe -Command \
    choco install -y windows-adk-deploy ntttcp ; \
    choco cache remove;

# # Install  Windows Assessment and Deployment Kit (Windows ADK) for Windows Performance Recorder (WPR)
# RUN powershell.exe -Command \
#     Invoke-WebRequest "https://go.microsoft.com/fwlink/?linkid=2271337" -OutFile c:\adksetup.exe ; \
#     Start-Process c:\adksetup.exe /quiet /installpath c:\adk -Wait ; \
#     Remove-Item c:\adksetup.exe -Force

CMD [ "powershell", "-Command", "Start-Sleep", "2147483" ]
