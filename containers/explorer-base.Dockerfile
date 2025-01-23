# Stage 1: Build Stage
FROM node:22-alpine AS explorer-builder

RUN apk add --no-cache git make gcc g++ python3 cairo-dev pango-dev

WORKDIR /src
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Minimal image containing only the built artifacts
FROM scratch AS explorer-base

WORKDIR /
COPY --from=explorer-builder /src/dist /cosmos-explorer
