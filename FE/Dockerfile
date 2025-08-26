# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy the static content from the FE folder to the Nginx html directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]
