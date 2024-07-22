# Use an appropriate base image for the build stage
FROM ubuntu:22.04 AS builder

# Install necessary dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y make git zlib1g-dev libssl-dev gperf cmake clang-14 libc++-14-dev libc++abi-14-dev

# Clone the repository
RUN git clone --recursive https://github.com/tdlib/telegram-bot-api.git

# Build the Telegram Bot API
WORKDIR /telegram-bot-api
RUN rm -rf build && \
    mkdir build && \
    cd build && \
    CXXFLAGS="-stdlib=libc++" CC=/usr/bin/clang-14 CXX=/usr/bin/clang++-14 cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. && \
    cmake --build . --target install

# Use a lightweight image for the final stage
FROM ubuntu:22.04

# Install runtime dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y zlib1g libssl3

# Copy the built binary from the builder stage
COPY --from=builder /telegram-bot-api/bin/telegram-bot-api /usr/local/bin/telegram-bot-api

# Expose the port that the Telegram API server will be running on
EXPOSE 8081

# Specify the variables you need
ARG TELEGRAM_API_ID
ARG TELEGRAM_API_HASH
ARG PORT

# Set environment variables for the API ID, API Hash, and Port
ENV TELEGRAM_API_ID=${TELEGRAM_API_ID}
ENV TELEGRAM_API_HASH=${TELEGRAM_API_HASH}
ENV PORT=${PORT}

# Define the command to run the Telegram API server
CMD ["sh", "-c", "telegram-bot-api --api-id=${TELEGRAM_API_ID} --api-hash=${TELEGRAM_API_HASH} --http-port=${PORT}"]
