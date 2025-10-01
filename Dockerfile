From nginx:alpine
# Remove default Nginx page
RUN rm -rf /usr/share/nginx/html/*

# Copy your custom HTML page into the Nginx web root
COPY index.html /usr/share/nginx/html/