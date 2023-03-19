# ubuntu-base-arm64
A customized ARM64 Ubuntu 22.04 LTS-based docker base image created for use in various containers.

TODO:
- [ ] Build documentation

# ubuntu-base-arm64: A base docker image built on Ubuntu 22.04 LTS ARM64
A customized ARM64 Ubuntu 22.04 LTS-based docker base image created for use in various docker projects.

Initially built to serve as the base of my [cardano-node-arm64(https://github.com/brav0charlie/cardano-node-arm64)] docker image.

## Customizations
- Start with arm64v8/ubuntu as a base image
- Install zsh, wget, git, vim, python3, python3-pip, bat, dnsutils, nano, libnuma-dev
  - Clean up
- Install locales
  - Set LANG to en_US.UTF-8
  - Set LC_ALL to en_US.UTF-8
- Create user `lovelace`
  - UID="1000"
  - GID="1000"
  - Set up home directory
- Copy container-dotfiles project to .dotfiles
  - Copy .zshrc into $HOME
- Set permissions
- Set container to run as user `lovelace`
- Set HOME to /home/${USERNAME}

##
See INFO file for details on initial source.