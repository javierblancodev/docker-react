# Multi-step build

# First fase: install dependencies and build the application
FROM node:18-alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# /app/build -> This is the folder that we really care about an need to use in the second fase

# Second fase: run our app

# Just by writing FROM, docker knows that the previous fase ends and starts a new fase

FROM nginx

# We use --from pointing to other fase (builder in this case) to copy or use from other fase  
# nginx docs recommend to place the app in the /usr/share/nginx/html folder since it will look there to start the app

COPY --from=builder /app/build /usr/share/nginx/html

# CMD -> We do not need to specify any primary command since nginx container will run a start command by default