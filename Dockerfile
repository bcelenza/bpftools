FROM ubuntu:22.04

# Install base tooling and libraries.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends \
        arping \
        bison \
        build-essential \
        cmake \
        flex \
        git \
        iperf \
        libclang-14-dev \
        libdebuginfod-dev \
        libedit-dev \
        libelf-dev \
        libfl-dev \
        libllvm14 \
        liblzma-dev \
        llvm-14-dev \
        netperf \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-venv \
        zip \
    && rm -rf /var/lib/apt/lists/* \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1

# Install BCC from source to ensure the latest version.
RUN git clone --depth 1 https://github.com/iovisor/bcc.git \
    && cd bcc \
    && mkdir build && cd build \
    # Set -DREVISION to format compatible with Python's PEP 440
    && cmake -DREVISION=$(date +"%Y.%m") .. \
    && make \
    && make install \
    && cmake -DREVISION=$(date +"%Y.%m") -DPYTHON_CMD=python3 .. \
    && cd src/python \
    && make \
    && make install \
    && cd / && rm -rf bcc

# Include BCC tools in the PATH.
ENV PATH="$PATH:/usr/share/bcc/tools"

# Default to a /src directory for any CLI-based operations.
WORKDIR /src