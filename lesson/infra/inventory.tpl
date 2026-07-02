[servers]
%{for name, instance in aws_instance.my-ubuntu-instance~}
${name}   ansible_host=${instance.public_ip}
%{endfor~}

%{for name, instance in aws_instance.my-ubuntu-instance~}
${name}   ansible_user=${local.ec2-instance_type[name].user}
%{endfor~}

[servers:vars]
ansible_python_interpreter=auto_silent
ansible_ssh_private_key_file=${ssh_private_key_file}
ansible_ssh_common_args='${ssh_common_args}'