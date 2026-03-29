# color-nginx

Simple Nginx container that serves HTTP and HTTPS and shows a color per container.

## Build
```
docker build -t color-nginx .
```

## Run
```
docker run -d --name test1 -p 8080:80 -p 8443:443 color-nginx
```

Open:
- http://localhost:8080
- https://localhost:8443
