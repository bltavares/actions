FROM clojure:lein-alpine

LABEL "com.github.actions.name"="cljfmt"
LABEL "com.github.actions.description"="Provides linting and fixes using cljfmt"
LABEL "com.github.actions.icon"="user-check"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="http://github.com/bltavares/actions"
LABEL "homepage"="http://github.com/bltavares/actions"
LABEL "maintainer"="Bruno Tavares <connect+githubactions@bltavares.com>"

ENV CLOJURE_VERSION=1.10.1.483

RUN apk --no-cache add \
  curl~=7 \
  jq~=1.6 \
  bash~=4 \
  git~=2

RUN wget https://download.clojure.org/install/linux-install-$CLOJURE_VERSION.sh && \
  chmod +x linux-install-$CLOJURE_VERSION.sh && \
  ./linux-install-$CLOJURE_VERSION.sh && \
  clojure -e "(clojure-version)"

COPY lib.sh /lib.sh
COPY entrypoint.sh /entrypoint.sh
COPY rewrite_projectclj.clj /rewrite_projectclj.clj
ENTRYPOINT ["/entrypoint.sh"]
