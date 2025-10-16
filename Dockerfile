# Use a lightweight official Python image
FROM python:3.12-slim-bullseye

# Set working directory
WORKDIR /app

# Copy only requirements first (for caching)
COPY requirements.txt .

# Install dependencies efficiently
RUN apt update -y && apt install -y --no-install-recommends awscli \
    && pip install --no-cache-dir -r requirements.txt \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Copy rest of the project files
COPY . .

# Expose Flask’s default port
EXPOSE 5000

# Run the application
CMD ["python", "application.py"]
