FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_VERSION="3.6.0"

RUN apt-get update
RUN apt-get install -y build-essential checkinstall software-properties-common llvm cmake wget git nano nasm yasm zip unzip pkg-config \
    libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev mysql-client default-libmysqlclient-dev

# Install Python 3.6.0
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    && tar xvf Python-${PYTHON_VERSION}.tar.xz \
    && rm Python-${PYTHON_VERSION}.tar.xz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure \
    && make altinstall \
    && cd / \
    && rm -rf Python-${PYTHON_VERSION}

ADD requirements.txt .
RUN python3.6 -m pip install -r requirements.txt

FROM ubuntu:latest

RUN apt-get update
ADD requirements.txt .
RUN python -m pip install -r requirements.txt