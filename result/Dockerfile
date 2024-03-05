FROM node:latest

WORKDIR /usr/local/app
COPY . .
RUN npm ci
RUN npm cache clean --force
EXPOSE 4000
ENV PORT=4000
CMD ["node", "server.js"]
