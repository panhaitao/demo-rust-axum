# Install

sudo curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# build

export PATH="$HOME/.cargo/bin:$PATH" || source $HOME/.cargo/env


# issue

1. Use alpline-v3.13 + docker:19.03 + Dind Build Images will exit with error: 
```
make: /bin/sh: Operation not permitted
```   
upgrade Docker to version 20.10.0 or later Reference https://github.com/alpinelinux/docker-alpine/issues/182
