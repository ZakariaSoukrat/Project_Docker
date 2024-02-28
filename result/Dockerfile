FROM node:latest

WORKDIR /usr/local/app
COPY package*.json ./
RUN npm ci
RUN npm install -g nodemon
RUN npm cache clean --force
RUN mv /usr/local/app/node_modules /node_modules
COPY . .
EXPOSE 4000
ENV PORT=4000
CMD ["node", "server.js"]
