FROM container-registry.oracle.com/graalvm/native-image:17-ol8 AS builder
WORKDIR /build
COPY . /build
RUN chmod 777 ./mvnw
RUN ./mvnw --no-transfer-progress native:compile -Pnative
FROM container-registry.oracle.com/os/oraclelinux:8-slim
EXPOSE 8080
COPY --from=builder /build/target/spring-boot3-native-demo app
ENTRYPOINT ["/app"]
