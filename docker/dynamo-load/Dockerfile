FROM node:latest

WORKDIR /usr/apps/dynamo-load
COPY . .

RUN mv .aws ~/.aws
RUN npm install aws-sdk

CMD ["node", "load.js", "<csv to load>", "<table to load to>"]
