# Use a lightweight base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy and install dependencies
COPY app/requirements.txt .
RUN pip install -r requirements.txt

# Copy the app
COPY app/ .

# Expose port
EXPOSE 80

# Run the application
CMD ["python", "app.py"]
