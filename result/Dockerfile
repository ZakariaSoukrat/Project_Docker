# Use official Node.js image as the base image
FROM node:latest

# Set working directory inside the container
WORKDIR /usr/local/app

# Copy package.json and package-lock.json to container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Expose port 4000 for the Node.js application
EXPOSE 4000

# Wait for PostgreSQL to be ready before starting the Node.js application
CMD ["node", "server.js"]
