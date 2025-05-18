# 构建阶段
# 尝试使用 node:lts (长期支持版本) 或 node:20 (Node.js 20的默认Debian基础镜像)
FROM node:lts AS build 
# 或者 FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm install && \
npm run build

# 运行阶段
# 保持与构建阶段一致
FROM node:lts AS runtime 
# 或者 FROM node:20 AS runtime
WORKDIR /app
COPY --from=build /app/dist /app
RUN npm install -g http-server

EXPOSE 8080

CMD ["http-server", "/app", "-p", "8080"]