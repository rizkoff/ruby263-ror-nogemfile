

BUILD:
docker build -t try-nginx .

RUN:
docker run -p8080:8080 --name nginx -d --rm try-nginx

