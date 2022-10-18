FROM debian:bullseye

# -- TODO: copy extra ca certs here
# COPY ./foo.crt /usr/local/share/ca-certificates/

RUN apt-get update -qq && \
    apt-get install -q -y curl zip unzip && \
    update-ca-certificates

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN groupadd -g 1010 builder && \
    useradd --gid builder --uid 1010 --home-dir /home/builder builder

WORKDIR /home/builder

# Copy sources
COPY --chown=builder:builder . /home/builder
RUN chown -R builder:builder /home/builder

USER builder:builder

# -- Install sdkman
RUN curl -s https://get.sdkman.io | bash && \
    chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh" && \
    source "$HOME/.sdkman/bin/sdkman-init.sh"

RUN sdk install java 19-amzn && \
    sdk install gradle 7.5.1 \
    sdk use java 19-amzn && \
    sdk use gradle 7.5.1

# -- Add cert to keytool \
RUN