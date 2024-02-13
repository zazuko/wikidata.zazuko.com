FROM docker.io/library/node:20-alpine

EXPOSE 8080

ENV TRIFID_CONFIG="config.json"

WORKDIR /app

# use tini for PID1
# https://github.com/krallin/tini
RUN apk add --no-cache tini

# install dependencies
COPY package.json package-lock.json ./
RUN npm install --only=production
COPY . .

# run as node user
USER 1000:1000

ENTRYPOINT ["tini", "--", "node", "/app/node_modules/trifid/server.js"]
