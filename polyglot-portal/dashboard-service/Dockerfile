# Stage 1: install dependencies
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# Stage 2: distroless Node runtime — no shell, no package manager
FROM gcr.io/distroless/nodejs20-debian12
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY . .
EXPOSE 3000
USER nonroot
CMD ["index.js"]