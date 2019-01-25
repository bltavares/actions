FROM google/dart:2

LABEL "com.github.actions.name"="dartanalyzer"
LABEL "com.github.actions.description"="Provides linting for Dart projects using dartanalyzer"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
  curl=7.* \
  jq=1.* \
  bash=4.* \
  git=1:2.* \
  && rm -rf /var/lib/apt/lists/*

RUN git clone --branch stable https://github.com/flutter/flutter.git /opt/flutter
ENV PATH ${PATH}:/opt/flutter/bin

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
