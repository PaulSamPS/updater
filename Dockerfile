FROM node:20.16
WORKDIR /app
COPY package*.json ./
RUN yarn install
COPY . .
EXPOSE 5000
CMD ["yarn", "dev"]
