# Use an official Python runtime as the base image
FROM python:3.9-slim

# Set the working directory within the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY app.py .

# Expose port 5000 to the outside world
EXPOSE 5000

# Define the command to run the application within the container
CMD ["python3", "app.py"]