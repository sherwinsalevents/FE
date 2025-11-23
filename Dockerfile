# Stage 1: Build React app
FROM node:18 AS builder

WORKDIR /app

# Copy package.json and lockfile
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Copy .env file (optional, used at build time)
COPY .env ./

# Build the React app for production
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:alpine

# Copy the build output to Nginx
COPY --from=builder /app/build /usr/share/nginx/html

# Optional: Copy custom Nginx config
# COPY default.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]