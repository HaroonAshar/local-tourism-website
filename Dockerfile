# Stage 1: Build
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Build project
RUN npx parcel build src/*.html --public-url ./

# Stage 2: Production (very small)
FROM node:18-alpine

WORKDIR /app

# Install only serve (lightweight)
RUN npm install -g serve

# Copy only built files from builder
COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["serve", "-s", "dist", "-l", "3000"]