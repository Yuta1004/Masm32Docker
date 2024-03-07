FROM python:3.10-slim-bullseye

WORKDIR /workdir

RUN apt update && \
    apt install -y \
        build-essential \
        gcc-multilib \
        g++-multilib \
        cmake \
        g++ \
        gdb \
        git && \
    pip install gdbgui && \
    git clone https://github.com/JWasm/JWasm.git && \
    cd JWasm && \
    cmake . && \
    make && \
    cp jwasm /usr/local/bin
