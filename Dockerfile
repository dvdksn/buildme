# syntax=docker/dockerfile:1

# build stage for building the program
FROM golang:1.22-alpine AS build
WORKDIR /src

# Download dependencies
RUN --mount=type=bind,src=go.mod,target=go.mod \
    --mount=type=bind,src=go.sum,target=go.sum \
    --mount=type=cache,target=/go/pkg/mod \
    go mod download

# Compile the program
RUN --mount=type=bind,target=. \
    --mount=type=cache,target=/go/pkg/mod \
    go build -o /buildme .

# final runtime stage
FROM alpine AS final

# Copy the binary from the build stage
COPY --from=build /buildme /

# Start the program
ENTRYPOINT ["/buildme"]
