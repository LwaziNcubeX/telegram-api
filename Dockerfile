# Use the existing image from the GitHub Container Registry
FROM ghcr.io/lukaszraczylo/tdlib-telegram-bot-api-docker/telegram-api-server:latest

# Expose the port that the Telegram API server will be running on
EXPOSE 8081

# Set environment variables for the API ID and API Hash
ENV TELEGRAM_API_ID=yourApiID
ENV TELEGRAM_API_HASH=yourApiHash
ENV PORT=8081

# Define the command to run the Telegram API server
CMD ["./telegram-bot-api", "--api-id=$TELEGRAM_API_ID", "--api-hash=$TELEGRAM_API_HASH", "--http-port=$PORT"]
