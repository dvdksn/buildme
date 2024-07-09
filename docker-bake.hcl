target "default" {
  target = "final"
  tags = ["buildme:latest"]
}

target "export" {
  target = "binaries"
  output = ["type=local,dest=./build"]
}
