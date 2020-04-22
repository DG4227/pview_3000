FROM node:lts-alpine

WORKDIR /vue_photo_viewer

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 8080
CMD [ "npm", "run", "dev" ]
