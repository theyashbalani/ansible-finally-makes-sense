# # resource "local_file" "ansible_hosts" {
# #   filename = "${path.module}/../hosts"
# #   content  = <<-EOT
# # [servers]
# # %{for name, instance in aws_instance.my-ubuntu-instance~}
# # ${name}   ansible_host=${instance.public_ip}
# # %{endfor~}

# # %{for name, instance in aws_instance.my-ubuntu-instance~}
# # ${name}   ansible_user=${local.ec2-instance_type[name].user}
# # %{endfor~}

# # [servers:vars]
# # ansible_python_interpreter=auto_silent
# # ansible_ssh_private_key_file=~/ansible-series/ansible-finally-makes-sense/lesson/infra/worker-node
# # ansible_ssh_common_args='-o StrictHostKeyChecking=no'
# # EOT
# # }

# resource "local_file" "ansible_hosts" {
#   filename        = "${path.module}/../inventory/${var.env}/hosts"
#   file_permission = "0664"
#   content = templatefile("${path.module}/inventory.tpl", {
#     aws_instances = [
#       for name, instance in aws_instance.my-ubuntu-instance : {
#         name      = name
#         public_ip = instance.public_ip
#         user      = local.ec2-instance_type[name].user
#       }
#     ]
#     ssh_private_key_file = "~/ansible-series/ansible-finally-makes-sense/lesson/infra/worker-node"
#     ssh_common_args      = "-o StrictHostKeyChecking=no"
#   })
# }
