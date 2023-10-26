FROM golang:1.21.0

# Add Maintainer Info
LABEL maintainer="Ruslan Minislamov"

ENV DEBIAN_FRONTEND=noninteractive
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Configure apt, install packages and tools
RUN apt-get update \
    #
    && apt-get -y install python3 python3-venv virtualenv python3-virtualenv \
    # Install task
    && curl -sL https://taskfile.dev/install.sh | sh -s -- -b /usr/local/bin 2>&1 \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /tmp/gotools

# Update this to "on" or "off" as appropriate
ENV GO111MODULE=auto
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
