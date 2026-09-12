FROM node:20-alpine

ARG GH_PACKAGES_TOKEN
ENV NODE_AUTH_TOKEN=$GH_PACKAGES_TOKEN

RUN npm config set //npm.pkg.github.com/:_authToken=$NODE_AUTH_TOKEN \
 && npm config set @brenovergilio:registry=https://npm.pkg.github.com

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev

COPY . .
EXPOSE 3000
CMD ["npm", "start"]