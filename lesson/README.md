# Ansible Overview

- **IaC (Infrastructure as Code)** act as a **Single Source of Truth** for all your infrastructure.
- **DevOps** main usecase is to reduce **time to market**, we want to make changes in **Minimum Time**, **Minimum Cost**, **Minimum Risk**.
- **Ansible** is **Agentless Configuration Management tool**, where agent is not required to be installed on managed nodes. It uses **SSH** protocol to connect and configure managed nodes.
- **Control Node** :- Where ansible is installed. This machine has IPs and SSH Keys of all managed nodes. This machine access and configure all the managed nodes using **Push based mechanism**.
- **Managed Node** :- Where changes are to be done using Ansible. These are target servers.
- **Playbook** is a set of instructions written in **YAML** files which are used to automate tasks on managed nodes. Imperative Blueprint.
- **Idempotency**: If we run the same playbook multiple times, it will have the same effect.
- **Configuration File** is used to configure the playbooks. This file is kept on the control node in **Default Path** `/etc/ansible/ansible.cfg`
- **Inventory** :- List of all managed nodes. These can be IP Addresses or Hostnames. **Inventory is optional**.
- **host file (inventory.ini)** :- File to connect control node to worker node. It contains IP addresses of all the worker nodes.

# Ansible Commands

- `ansible <node> -m ping` when ansible is configured globally.

  > `<node>` is name of the group of hosts in the inventory file.\
  > `-m` is module\
  > `ping` is the module to be executed.

- `ansible -i hosts all -m ping` when ansible is configured locally and inventory file is passed as an argument.

  > `-i` is for inventory file path\
  > `all` is for all the hosts in the inventory file

- `ansible -i hosts <node> -a <shell-command> -v` when ad-hoc command is to be executed

  > `-a` is for ad-hoc command
  > `<shell-command>` is the linux shell command to be executed on the managed nodes
  > `-v` increases the verbosity of the command

- `ansible -i hosts <node> -m setup -v`

  > `setup` is the module to fetch facts from the managed nodes

- `ansible-playbook playbook.yaml` when playbook is to be executed without inventory file

  > `playbook.yaml` is the name of the playbook

- `ansible-playbook -i hosts playbook.yaml` when playbook is to be executed with inventory file

  > `-i` is for inventory file path
  > `playbook.yaml` is the name of the playbook
