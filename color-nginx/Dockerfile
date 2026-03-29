FROM nginx:alpine

RUN apk add --no-cache bash openssl

WORKDIR /app

COPY nginx.conf /etc/nginx/nginx.conf
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY html/index.template.html /usr/share/nginx/html/index.template.html

RUN chmod +x /docker-entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
