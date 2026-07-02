# Output for count

# output "ec2-public-ip" {
#     value = aws_instance.my-ubuntu-instance[*].public_ip        # [*] splat expression
# }

# output "ec2-public-dns" {
#     value = aws_instance.my-ubuntu-instance[*].public_dns        # [*] splat expression
# }

# Output for for_each
output "ec2-public-ip" {
  value = [
    for n, instance in aws_instance.my-ubuntu-instance : {
      name      = n
      public_ip = instance.public_ip
      user      = local.ec2-instance_type[n].user
    }
  ]
}

output "ec2-public-dns" {
  value = [
    for name, instance in aws_instance.my-ubuntu-instance : {
      name       = name
      public_dns = instance.public_dns
      user       = local.ec2-instance_type[name].user
    }
  ]
}

