FROM node:20.19.0-alpine3.21 AS build
WORKDIR /app
COPY . .
RUN corepack enable && \
    corepack prepare pnpm@latest --activate && \
    pnpm install && \
    pnpm run build

FROM svenstaro/miniserve:0.29.0-alpine AS runtime
# 设置端口
ENV MINISERVE_PORT=8080
WORKDIR /app
COPY --from=build /app/dist /app

EXPOSE 8080

CMD ["--index", "/app/index.html"]