FROM alpine:3.20.1

RUN apk update && apk upgrade

RUN apk add --no-cache nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/yait-oul.42.fr.key \
  -out /etc/nginx/ssl/yait-oul.42.fr.crt \
  -subj "/CN=yait-oul.42.fr"

CMD ["nginx", "-g", "daemon off;"]
