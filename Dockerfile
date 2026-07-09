FROM node:26.5.0-alpine3.23 as builder
WORKDIR /usr/src/app
COPY package.json .
COPY package-lock.json* .
RUN npm ci

FROM node:26.5.0-alpine3.23
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/ /usr/src/app/
COPY . .
CMD ["npx", "quartz", "build", "--serve"]
