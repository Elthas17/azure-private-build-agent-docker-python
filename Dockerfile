FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

ARG WORKDIRECTORY
ARG AGENT_TOOLSDIRECTORY

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -qq --no-install-recommends \
    apt-transport-https \
    apt-utils \
    ca-certificates \
    curl \
    git \
    iputils-ping \
    jq \
    lsb-release \
    software-properties-common \
    unixodbc-dev \
    python3-dev\
    gcc \
    g++ \
    zip \
    libxml2


#Install python 3.7
# Turn off work proxy, corporate proxy often blocks this repo
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.7\
    python3.7-dev\
    python3.7-distutils\
    python3.7-venv

#Install python 3.9
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.9\
    python3.9-dev\
    python3.9-distutils\
    python3.9-venv

#Install python 3.10
# RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10\
    python3.10-dev\
    python3.10-distutils\
    python3.10-venv

#Install python 3.11
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.11\
    python3.11-dev\
    python3.11-distutils\
    python3.11-venv

#Install python 3.12
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.12\
    python3.12-dev\
    python3.12-distutils\
    python3.12-venv

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip\
    python3-wheel

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

# Configure correct directory structure for python versions
# https://github.com/microsoft/azure-pipelines-tool-lib/blob/master/docs/overview.md#tool-cache
# https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/use-python-version-v0?view=azure-pipeline
# to check which python version got installed into the container, run the container interactively
# docker run -it imagename sh
# then adapt the folder structure accordingly
RUN mkdir -p /azp/_work/_tool/Python/3.7.17/
RUN cd /azp/_work/_tool/Python/3.7.17/ && touch x64.complete && python3.7 -m venv x64

RUN mkdir -p /azp/_work/_tool/Python/3.9.18/
RUN cd /azp/_work/_tool/Python/3.9.18/ && touch x64.complete && python3.9 -m venv x64

RUN mkdir -p /azp/_work/_tool/Python/3.10.13/
RUN cd /azp/_work/_tool/Python/3.10.13/ && touch x64.complete && python3.10 -m venv x64

RUN mkdir -p /azp/_work/_tool/Python/3.11.6/
RUN cd /azp/_work/_tool/Python/3.11.6/ && touch x64.complete && python3.11 -m venv x64

RUN mkdir -p /azp/_work/_tool/Python/3.12.0/
RUN cd /azp/_work/_tool/Python/3.12.0/ && touch x64.complete && python3.12 -m venv x64

# if docker cant find the start.sh file, it might be because of the 'line separator' which windows changes silently
# line separator of .sh file should be LF, not CRLF,
# you can change this in pycharm bottom right while having the file open
COPY start.sh .
RUN chmod +x start.sh

CMD [ "./start.sh" ]
