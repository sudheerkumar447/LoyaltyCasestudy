FROM nginx:alpine
MAINTAINER Sudheer Kumar
COPY default.conf /etc/nginx/conf.d/
COPY index.html /usr/share/nginx/html/
Expose 8080

