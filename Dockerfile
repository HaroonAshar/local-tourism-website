FROM node:18
WORKDIR /app
COPY . .
RUN npm install -g parcel
CMD ["npx", "parcel", "src/index.html"]
