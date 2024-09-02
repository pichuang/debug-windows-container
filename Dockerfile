FROM mcr.microsoft.com/windows/servercore:ltsc2022
LABEL org.opencontainers.image.title = "Debug Container for Windows" \
      org.opencontainers.image.authors = "Phil Huang <phil.huang@microsoft.com>" \
      org.opencontainers.image.source = "https://github.com/pichuang/debug-windows-container" \
      org.opencontainers.image.description = "Debug Container for Windows node" \
      org.opencontainers.image.vendor = "divecode.in" \
      org.opencontainers.image.url = "ghcr.io/pichuang/debug-windows-container:master" \
      org.opencontainers.image.documentation = "https://github.com/pichuang/debug-windows-container"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Create the scripts folder
RUN New-Item -ItemType Directory -Path C:\scripts

# Copy the tools folder to the container
COPY scripts C:/scripts

RUN Set-ExecutionPolicy Bypass -Scope Process -Force; \
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; \
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')); \
    choco install -y ntttcp netcat python3 git wget vim; \
    # choco install -y windows-adk-deploy ntttcp netcat python3 git wget vim; \
    choco cache remove; \
    # Install pip
    py -m ensurepip --upgrade

CMD [ "powershell", "-Command", "Start-Sleep", "2147483" ]
