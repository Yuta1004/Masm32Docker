FROM debian:stable-slim

WORKDIR /workdir

RUN apt update && \
    apt install -y build-essential gcc-multilib g++-multilib cmake g++ git && \
    git clone https://github.com/JWasm/JWasm.git && \
    cd JWasm && \
    cmake . && \
    make && \
    cp jwasm /usr/local/bin
