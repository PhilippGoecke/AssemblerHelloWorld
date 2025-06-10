FROM debian:bookworm-slim as build-env

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt update && apt upgrade -y \
  # install tools
  && apt install -y --no-install-recommends nasm

# add user and set home directory
ARG USER=asm
RUN useradd --create-home --shell /bin/bash $USER
ARG HOME="/home/$USER"
WORKDIR $HOME
USER $USER

COPY hello.asm hello.asm

RUN nasm -f elf32 -o hello.o hello.asm \
  && ld -m elf_i386 -o hello hello.o

FROM debian:bookworm-slim

# add user and set home directory
ARG USER=asm
RUN useradd --create-home --shell /bin/bash $USER
ARG HOME="/home/$USER"
WORKDIR $HOME
USER $USER

COPY --from=build-env $HOME/hello $HOME/hello

CMD ./hello
