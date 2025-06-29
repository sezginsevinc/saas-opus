# API Dockerfile
FROM node:18-alpine

# Install dependencies for node-gyp
RUN apk add --no-cache python3 g++ make

WORKDIR /app

# Copy package files
COPY package*.json ./
COPY tsconfig.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build TypeScript
RUN npm run build

# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start"]