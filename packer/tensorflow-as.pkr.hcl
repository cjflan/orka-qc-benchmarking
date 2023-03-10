variable "ORKA_IMAGE" {
  default = env("ORKA_IMAGE")
}
variable "ORKA_ENDPOINT" {
  default = env("ORKA_ENDPOINT")
}
variable "ORKA_USER" {
  default = env("ORKA_USER")
}
variable "ORKA_PASSWORD" {
  default = env("ORKA_PASSWORD")
}
variable "ORKA_IMAGE_NAME_PREFIX" {
  default = "packer"
}

source "macstadium-orka" "image" {
  source_image    = var.ORKA_IMAGE
  image_name      = "${var.ORKA_IMAGE_NAME_PREFIX}-{{timestamp}}"
  orka_endpoint   = var.ORKA_ENDPOINT
  orka_user       = var.ORKA_USER
  orka_password   = var.ORKA_PASSWORD
  image_precopy   = false
  simulate_create = false
  no_create_image = false
  no_delete_vm    = false
}

build {
  sources = [
    "macstadium-orka.image"
  ]
   provisioner "shell" {
    inline = [
      // The base image this script builds on top of needs to have brew and Xcode installed and the 'admin' user in the sudoers file
      "brew update",
      "brew upgrade",
      "brew install coreutils",
      "brew install pyenv",
      "pyenv install 3.11.2",
      "brew install bazelisk",
      "brew install openjdk@11",
      "sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk"
    ]
  }
}