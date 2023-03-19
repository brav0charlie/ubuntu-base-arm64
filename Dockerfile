FROM arm64v8/ubuntu:latest
LABEL maintainer="Bill Clark (bill@billclark.io)"
LABEL github_url="https://github.com/brav0charlie/ubuntu-base-arm64"
LABEL org.opencontainers.image.source="https://github.com/brav0charlie/ubuntu-base-arm64"

# Install preferred packages (libnuma-dev required to run cardano-node binary)
RUN apt-get update \
 && apt-get install -y \
    zsh \
    wget \
    git \
    vim \
    python3 \
    python3-pip \
    bat \
    dnsutils \
    nano \
    libnuma-dev \
 && rm -rf /var/lib/apt/lists/*

# Set up locale (prevents error when using ZSH powerline fonts)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 
ENV LC_ALL en_US.UTF-8

# Setup default user environment
ARG USERNAME="lovelace"
ARG USERID="1000"
ARG GROUPID="1000"
RUN groupadd -g $GROUPID -r $USERNAME \
 && useradd --no-log-init -r --gid $GROUPID -u $USERID $USERNAME \
 && mkdir /home/$USERNAME
COPY ./container-dotfiles/zshrc /home/${USERNAME}/.zshrc
COPY ./container-dotfiles /home/${USERNAME}/.dotfiles
RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} \
 && chown -R ${USERNAME}:${USERNAME} /usr/local \
 && echo ${USERNAME}:${USERNAME} | chpasswd \
 && chsh -s /usr/bin/zsh ${USERNAME}
USER ${USERNAME}
ENV HOME="/home/${USERNAME}"
