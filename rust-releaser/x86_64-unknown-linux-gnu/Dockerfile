FROM rustreleaser/cross:x86_64-unknown-linux-gnu

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH \
  RUST_VERSION=1.33.0

# Action toolchain
RUN apt-get update -qq && apt-get install -qqy --no-install-recommends \
    curl=7.* \
    bash=4.* \
    git=1:* \
    zip=3* \
  && curl -fsSL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /usr/bin/jq \
  && chmod +x /usr/bin/jq \
  && rm -rf /var/lib/apt/lists/*

# Rust toolchain
RUN curl https://sh.rustup.rs -sSf -o /rustup.sh \
  && sh /rustup.sh -y \
  --no-modify-path \
  --default-toolchain $RUST_VERSION \
  && rm /rustup.sh \
  && chmod -R a+w $RUSTUP_HOME $CARGO_HOME

# Cross compilation target toolchain
RUN rustup target add x86_64-unknown-linux-gnu

# And tool for defining the type of lib to produce: dynamic OR static
RUN cargo install --force cargo-crate-type

COPY entrypoint.sh /entrypoint.sh
COPY lib.sh /lib.sh
COPY releaser.sh /releaser.sh
ENTRYPOINT ["/entrypoint.sh"]
