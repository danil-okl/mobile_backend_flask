# Use a stable and reliable Python version
FROM python:3.11-slim

# Set the working directory inside the container
WORKDIR /app

# Copy dependency file first (for better caching)
COPY requirements.txt .

# Install dependencies without cache to reduce image size
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of your project files into the container
COPY . .

# Expose the port your Flask app will run on
EXPOSE 8080

# Start the Flask app with Gunicorn
CMD ["gunicorn", "--workers", "1", "--bind", ":8080", "--timeout", "600", "backend:app"]
