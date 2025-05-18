# 构建阶段
FROM node:lts AS build 
WORKDIR /app
COPY . .
RUN npm install && \
npm run build

# 运行阶段
FROM node:lts AS runtime 
WORKDIR /app
COPY --from=build /app/dist /app
RUN npm install -g http-server

# 添加描述标签
LABEL org.opencontainers.image.description="文字游戏: 我的文字修仙全靠刷"

EXPOSE 8080

CMD ["http-server", "/app", "-p", "8080"]