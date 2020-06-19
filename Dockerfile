# => Build container
FROM node:alpine as builder
WORKDIR /app
COPY package-lock.json .

COPY . .
RUN npm install
RUN npm run-script build

# => Run container
FROM centos/nginx-114-centos7

# Nginx config
USER root
RUN rm -f /etc/nginx/nginx.conf
COPY conf/conf.d/default.conf /etc/nginx/nginx.conf
USER 1001

# Static build
COPY --from=builder /app/build ./

# Default port exposure
EXPOSE 8080

# Copy .env file and shell script to container
COPY ./env.sh ./
COPY .env ./

USER root

# Support random user created by OpenShift
RUN chgrp -R 0 ./ && \
    chmod -R g=u ./

USER 1001

# Start Nginx server
CMD ["/bin/bash", "-c", "./env.sh && nginx -g \"daemon off;\""]