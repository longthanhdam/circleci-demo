# Stage 1: Build React App
FROM node:16-alpine AS build-stage

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code into the container
COPY . ./

# Build the React app
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:latest

# Copy built files from the previous stage to Nginx
COPY --from=build-stage /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

