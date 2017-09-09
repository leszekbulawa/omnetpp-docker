FROM ubuntu:latest
MAINTAINER Leszek Bulawa <leszekbu@gmail.com>
LABEL Description="Docker image for Omnet++"

RUN apt-get update

# General dependencies
RUN apt-get install -y \
    git \
    wget \
    vim \
    build-essential \
    gcc \
    g++ \
    bison \
    flex \
    perl \
    qt5-default \
    tcl-dev \
    tk-dev \
    libxml2-dev \
    zlib1g-dev \
    default-jre \
    doxygen \
    graphviz \
    xvfb

# QT
RUN apt-get install -y \
    libopenscenegraph-dev \
    openscenegraph-plugin-osgearth \
    libosgearth-dev \
    qt5-default \
    libxml2-dev \
    zlib1g-dev \
    default-jre \
    libwebkitgtk-3.0-0

# Create working directory
RUN mkdir -p /opt/omnetpp
WORKDIR /opt/omnetpp

# Omnet++ source is already in repository. Copy it to container and unpack
COPY omnetpp-5.1.1-src-linux.tgz /opt/omnetpp
RUN tar xf omnetpp-5.1.1-src-linux.tgz

# Set path for compilation
ENV PATH $PATH:/opt/omnetpp/omnetpp-5.1.1/bin

# Configure and compile Omnet++
RUN cd omnetpp-5.1.1 && \
    xvfb-run ./configure && \
    make

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt && \
    rm /opt/omnetpp/omnetpp-5.1.1-src-linux.tgz
