# key pair
# create using `ssh-keygen` command 
resource "aws_key_pair" "my-key-pair" {

  for_each   = local.ec2-instance_type
  key_name   = each.key
  public_key = each.value.ssh_key

  tags = {
    Environment = var.env
  }
}

# VPC & Security Group
resource "aws_default_vpc" "my-default-vpc" {
}

resource "aws_default_security_group" "my-default-sg" {
  vpc_id = aws_default_vpc.my-default-vpc.id # interpolation

  # inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH Open to All"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP Open to All"
  }

  # outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # equivalent to all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outbound Open to All"
  }
}

# ec2 instance
resource "aws_instance" "my-ubuntu-instance" {

  #count = 2   # meta argument

  depends_on = [
    aws_default_vpc.my-default-vpc,
    aws_default_security_group.my-default-sg,
  ]

  for_each = local.ec2-instance_type
  tags = {
    Name        = each.key
    Environment = var.env
  }

  ami                    = each.value.ami                                # data block output
  instance_type          = each.value.instance_type                      # interpolation
  key_name               = aws_key_pair.my-key-pair[each.key].key_name   # interpolation
  vpc_security_group_ids = [aws_default_security_group.my-default-sg.id] # interpolation

  user_data_base64 = (
    each.value.os_type == "ubuntu" ? filebase64("${path.module}/../../installation/install-ansible.sh") :
    each.value.os_type == "redhat" ? filebase64("${path.module}/../../installation/install-python.sh") :
    null
  )

  root_block_device {
    volume_size = var.env == "prd" ? 20 : var.ec2-root-storage-size # if condition ? then : else variable referenced
    volume_type = "gp3"                                             # gp3, gp2, io1, io2, st1, sc1, or standard
  }
}


# resource "aws_instance" "my-exsting-instance" {
#   ami           = "unknown"
#   instance_type = "unknown"

#   # prevent accidental deletion
#   lifecycle {
#     prevent_destroy = true
#   }
# }




