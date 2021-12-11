ARG UBUNTU_TAG=20.04
FROM ubuntu:"$UBUNTU_TAG"

ENV LANG=C.UTF-8
RUN \
    apt-get update && \
    apt-get install --assume-yes curl gcc git libgmp-dev libtinfo5 nano make sudo

ARG GHCUP_VERSION=0.1.17.4
RUN \
    curl --output /usr/local/bin/ghcup "https://downloads.haskell.org/~ghcup/$GHCUP_VERSION/x86_64-linux-ghcup-$GHCUP_VERSION" && \
    chmod +x /usr/local/bin/ghcup && \
    ghcup --version

ARG USER_NAME=haskell
RUN \
    useradd --create-home --shell "$( which bash )" "$USER_NAME" && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" | tee "/etc/sudoers.d/$USER_NAME"
USER "$USER_NAME"
ENV PATH="/home/$USER_NAME/.local/bin:/home/$USER_NAME/.cabal/bin:/home/$USER_NAME/.ghcup/bin:$PATH"
WORKDIR "/home/$USER_NAME"

ARG GHC_VERSION=9.2.1
RUN \
    ghcup install ghc "$GHC_VERSION" --set && \
    ghc --version

ARG CABAL_VERSION=3.6.2.0
RUN \
    ghcup install cabal "$CABAL_VERSION" --set && \
    cabal --version

ARG HLINT_VERSION=3.3.4
RUN \
    curl --location --output hlint.tgz "https://github.com/ndmitchell/hlint/releases/download/v$HLINT_VERSION/hlint-$HLINT_VERSION-x86_64-linux.tar.gz" && \
    tar --extract --file hlint.tgz && \
    mkdir --parents "/home/$USER_NAME/.local/bin" && \
    cp "hlint-$HLINT_VERSION/hlint" "/home/$USER_NAME/.local/bin" && \
    rm --recursive hlint.tgz "hlint-$HLINT_VERSION" && \
    hlint --version

ARG BRITTANY_VERSION=0.14.0.0
RUN \
    curl --location --output brittany "https://github.com/tfausak/brittany/releases/download/$BRITTANY_VERSION/brittany-$BRITTANY_VERSION-ubuntu" && \
    chmod +x brittany && \
    mv brittany "/home/$USER_NAME/.local/bin" && \
    brittany --version
