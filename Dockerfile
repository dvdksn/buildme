# syntax=docker/dockerfile:1

ARG GO_VERSION=1.22

# build stage for building the program
FROM golang:${GO_VERSION}-alpine AS build
ARG APP_VERSION="v0.0.0+unknown"
WORKDIR /src

# Download dependencies
COPY go.mod go.sum .
RUN go mod download

# Compile the program
COPY . .
RUN go build -ldflags "-X main.version=$APP_VERSION" -o /buildme .

# final runtime stage
FROM alpine AS final

# Copy the binary from the build stage
COPY --from=build /buildme /

# Start the program
ENTRYPOINT ["/buildme"]
