# Stage 1: Build
FROM maven:3-openjdk-17 AS build
WORKDIR /app

# Copy toàn bộ source code vào container
COPY . .

# Build project bằng Maven (bỏ qua test để build nhanh hơn)
RUN mvn clean package -DskipTests

# Stage 2: Run
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy file build từ giai đoạn trước vào container
COPY --from=build /app/target/MyApp-1.0.jar myapp.jar

# Mở cổng 8080
EXPOSE 8181

# Chạy ứng dụng
ENTRYPOINT ["java","-jar","myapp.jar"]
