FROM node:alpine as builder
#as builder below this is the builder phase to install dependencies to build our application
WORKDIR '/app'
COPY package.json ./
RUN npm cache clean --force && \
    rm -f package-lock.json && \
    rm -rf node_modules && \
    npm install
COPY ./ ./
RUN npm run build

#/app/build <--- all the stuff rewuired for the prod, copy for run phase

#second from second phase
FROM nginx
COPY --from=builder /app/build  /usr/share/nginx/html
