# syntax=docker/dockerfile:1

# build stage for building the program
FROM --platform=$BUILDPLATFORM golang:1.22-alpine AS build
ARG TARGETOS
ARG TARGETARCH
WORKDIR /src

# Download dependencies
COPY go.mod go.sum .
RUN go mod download

# Compile the program
COPY . .
RUN GOOS=$TARGETOS GOARCH=$TARGETARCH go build -o /buildme .

# final runtime stage
FROM alpine AS final

# Copy the binary from the build stage
COPY --from=build /buildme /

# Start the program
ENTRYPOINT ["/buildme"]

# binaries stage for exporting compiled binaries
FROM scratch AS binaries
COPY --from=build /buildme /
