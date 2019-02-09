FROM node:alpine as builder

WORKDIR '/app'

RUN apk update && apk add yarn

COPY package.json .
RUN yarn install

COPY . .
RUN yarn build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
