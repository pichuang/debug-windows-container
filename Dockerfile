FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL org.opencontainers.image.title = "Debug Container for Windows" \
      org.opencontainers.image.authors = "Phil Huang <phil.huang@microsoft.com>" \
      org.opencontainers.image.source = "https://github.com/pichuang/debug-windows-container" \
      org.opencontainers.image.description = "Debug Container for Windows node" \
      org.opencontainers.image.vendor = "divecode.in" \
      org.opencontainers.image.url = "ghcr.io/pichuang/debug-windows-container:master" \
      org.opencontainers.image.documentation = "https://github.com/pichuang/debug-windows-container"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Chocolatey CLI
# https://docs.chocolatey.org/en-us/choco/setup/#requirements
RUN powershell.exe -Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# RUN @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

RUN powershell.exe -Command \
    choco install -y wget; \
    # choco install -y windows-adk-deploy ntttcp netcat python3 git wget; \
    choco cache remove;

CMD [ "powershell", "-Command", "Start-Sleep", "2147483" ]
