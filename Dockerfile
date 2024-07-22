# Use an official Ubuntu as a parent image
FROM ubuntu:22.04

# Set environment variables for non-interactive installation
ENV DEBIAN_FRONTEND=noninteractive

# Specify the variables you need at build time
ARG TELEGRAM_API_ID
ARG TELEGRAM_API_HASH

# Update and install dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        make \
        zlib1g-dev \
        libssl-dev \
        gperf \
        cmake \
        g++ \
        wget \
        && apt-get clean

# Copy the pre-built binary into the container
COPY telegram-bot-api/telegram-bot-api /usr/local/bin/telegram-bot-api

# Make sure the binary is executable
RUN chmod +x /usr/local/bin/telegram-bot-api

# Expose the default HTTP port
EXPOSE 8081

# Use the build-time arguments to set environment variables
ENV TELEGRAM_API_ID=${TELEGRAM_API_ID}
ENV TELEGRAM_API_HASH=${TELEGRAM_API_HASH}

# Command to run the Telegram Bot API server
CMD ["telegram-bot-api", "--api-id=${TELEGRAM_API_ID}", "--api-hash=${TELEGRAM_API_HASH}", "--local"]
