FROM node:latest

WORKDIR /usr/local/app
COPY . .
RUN npm ci
RUN npm cache clean --force
RUN mv /usr/local/app/node_modules /node_modules
EXPOSE 4000
ENV PORT=4000
CMD ["node", "server.js"]

