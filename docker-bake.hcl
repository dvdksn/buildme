target "default" {
  target = "final"
  tags = ["buildme:latest"]
}

target "_export" {
  target = "binaries"
  output = ["type=local,dest=./build"]
}

target "export" {
  inherits = ["_export"]
  platforms = ["local"]
}

target "export-all" {
  inherits = ["_export"]
  platforms = [
    "darwin/amd64",
    "darwin/arm64",
    "linux/amd64",
    "linux/arm/v6",
    "linux/arm/v7",
    "linux/arm64",
    "linux/ppc64le",
    "linux/riscv64",
    "linux/s390x",
    "windows/amd64",
    "windows/arm64"
  ]
}
