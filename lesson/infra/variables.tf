# variable "ec2-instance_type" {
#   type = map(object({
#     ami           = string
#     user          = string
#     os_type       = string
#     instance_type = string
#   }))
#   description = "The type of instance to launch"
#   default = {
# }

locals {
  ec2-instance_type = {
    # control-ubuntu = {
    #   ami           = data.aws_ami.ubuntu.id
    #   user          = "ubuntu"
    #   os_type       = "ubuntu"
    #   instance_type = "t2.micro"
    #   ssh_key       = file("control-node.pub")
    # }
    worker-ubuntu = {
      ami           = data.aws_ami.ubuntu.id
      user          = "ubuntu"
      os_type       = "ubuntu"
      instance_type = "t2.micro"
      ssh_key       = file("worker-node.pub")
    }
    worker-redhat = {
      ami           = data.aws_ami.redhat.id
      user          = "ec2-user"
      os_type       = "redhat"
      instance_type = "t2.micro"
      ssh_key       = file("worker-node.pub")
    }
    worker-amazon = {
      ami           = data.aws_ami.amazon.id
      user          = "ec2-user"
      os_type       = "amazon"
      instance_type = "t2.micro"
      ssh_key       = file("worker-node.pub")
    }
  }
}

variable "ec2-root-storage-size" {
  type        = number
  description = "The size of the root storage"
  default     = 10
}

variable "env" {
  type        = string
  description = "The environment name"
  default     = "dev"
}
