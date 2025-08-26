# Stage 1: Build environment with system dependencies
FROM python:3.11-slim-bookworm

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install system dependencies required for OpenCV and other libraries
RUN apt-get update && apt-get install -y --no-install-recommends \
    # OpenCV dependencies
    libgl1-mesa-glx \
    libglib2.0-0 \
    # Clean up
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up a non-root user
RUN useradd -m -u 1000 -s /bin/bash appuser
USER appuser

# Set the working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY --chown=appuser:appuser ./requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY --chown=appuser:appuser . .

# Expose the port the app runs on
EXPOSE 8080

# The command to run the application will be taken from the Procfile by Railway
# Or you can specify it here:
# CMD gunicorn --bind 0.0.0.0:$PORT --workers 1 --threads 8 --timeout 0 BE.app:app
