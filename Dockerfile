# Docker file for production environment

# builder phase
FROM node:alpine AS builder 
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build
# /app/build ->> everything will be contained here

# run phase, terminates first block
FROM nginx
# copy over something from another phase ^^^
COPY --from=builder /app/build /usr/share/nginx/html
# default command starts up NGINX for us, so we don't have to run any specific command