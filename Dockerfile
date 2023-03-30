###Multi layered build for client
## step1 : to run the build
## step2 : to stage it on top of nginx as proxy server 
### STAGE 1: Build ###
## using base image
FROM node:12.7-alpine AS build
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
###RUN npm install
COPY . .
RUN rm -rf node_modules
RUN npm install
RUN npm run build
### STAGE 2: Run ###
FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/client /usr/share/nginx/html
