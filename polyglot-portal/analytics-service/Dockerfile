# Stage 1: compile a fully self-contained binary
FROM golang:1.22-alpine AS build
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o analytics main.go

# Stage 2: distroless runtime — literally just the binary
FROM gcr.io/distroless/static-debian12
WORKDIR /app
COPY --from=build /app/analytics .
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["./analytics"]