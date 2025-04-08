FROM nginx:alpine3.21-slim
COPY build/ /usr/share/nginx/html/
EXPOSE 80