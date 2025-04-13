# Stage 1: Build the Angular app
FROM node:18-alpine as builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build --configuration production

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the built Angular files from the builder
COPY --from=builder /app/dist/gestion-de-stock /usr/share/nginx/html

# Optional: Replace the default Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
