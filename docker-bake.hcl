target "default" {
  target = "final"
  args = {
    GO_VERSION = null
    APP_VERSION = null
  }
  tags = ["buildme:latest"]
}
