FROM node:current-buster-slim

RUN apt-get update
RUN apt-get install -y can-utils

RUN npm install pm2@latest

COPY njshttp.js /njshttp/njshttp.js
COPY app.yaml /app.yaml
