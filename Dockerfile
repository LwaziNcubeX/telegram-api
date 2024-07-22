# Use the existing image from the GitHub Container Registry
FROM ghcr.io/lukaszraczylo/tdlib-telegram-bot-api-docker/telegram-api-server:latest

# Specify the variables you need
ARG TELEGRAM_API_ID
ARG TELEGRAM_API_HASH
ARG PORT

# Set environment variables for the API ID, API Hash, and Port
ENV TELEGRAM_API_ID=${TELEGRAM_API_ID}
ENV TELEGRAM_API_HASH=${TELEGRAM_API_HASH}
ENV PORT=${PORT}

# Expose the port that the Telegram API server will be running on
EXPOSE ${PORT}

# Define the command to run the Telegram API server
CMD ["./telegram-bot-api", "--api-id=${TELEGRAM_API_ID}", "--api-hash=${TELEGRAM_API_HASH}", "--http-port=${PORT}"]
