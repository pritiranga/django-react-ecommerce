# Stage 1: Build React app
FROM node:18 AS build

WORKDIR /app

# Copy package files
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the frontend source code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve React app using nginx
FROM nginx:alpine

# Copy build output to nginx html directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
