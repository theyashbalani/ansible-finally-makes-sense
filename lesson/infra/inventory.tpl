[servers]
%{ for instance in get_aws_instances ~}
${instance.name} ansible_host=${instance.public_ip}
%{ endfor }

%{ for instance in get_aws_instances ~}
${instance.name} ansible_user=${instance.user}
%{ endfor }

[servers:vars]
ansible_python_interpreter=auto_silent
ansible_ssh_private_key_file=${ssh_private_key_file}
ansible_host_key_checking=false