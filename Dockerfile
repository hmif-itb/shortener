FROM node:20 AS BUILD_IMAGE

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

# Copy required files for packages 

COPY ["./frontend/","/app/frontend/"]

COPY ["./src/package.json","./src/pnpm-lock.yaml", "/app/src/"]

COPY ["VERSION", "./"]

# Install dependencies for backend

RUN pnpm install --frozen-lockfile --recursive

COPY src src

# Install dependencies for frontend and build it

WORKDIR /app/frontend
RUN NODE_ENV=production
RUN pnpm build

FROM node:20

WORKDIR /app

COPY --from=BUILD_IMAGE /app/dist ./dist
COPY --from=BUILD_IMAGE /app/src ./src
COPY --from=BUILD_IMAGE /app/VERSION ./VERSION

EXPOSE 3000

CMD ["./src/index.js"]