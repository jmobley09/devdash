FROM node:alpine as node
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH
COPY package*.json ./
# Silent to make the output not as ugly.
RUN npm ci --silent && npm install react-scripts@3.4.1 -g --silent
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=node /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]