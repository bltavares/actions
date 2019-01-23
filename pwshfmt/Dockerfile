FROM mcr.microsoft.com/powershell:6.1.0-rc.1-alpine-3.8

LABEL "com.github.actions.name"="pwshfmt"
LABEL "com.github.actions.description"="Provides Powershell formatter using PowerShell-Beautifier"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="green"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"


RUN pwsh -c 'Install-Module -Name PowerShell-Beautifier -Force'
RUN pwsh -c 'Import-Module PowerShell-Beautifier.psd1'

RUN apk --no-cache add \
  curl=7.61.1-r1 \
  jq=1.6_rc1-r1 \
  bash=4.4.19-r1 \
  git=2.18.1-r0

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]