FROM node:14 as build

WORKDIR /APP

COPY package.json package.json
COPY rollup.config.js rollup.config.js 
COPY src/ src/
COPY public/ public/

RUN npm install
RUN npm run build

FROM nginx:1.19-alpine

RUN mkdir /etc/nginx/logs
COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=build /APP/public/ /etc/nginx/srv
