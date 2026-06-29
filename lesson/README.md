# Ansible Overview

- **IaC (Infrastructure as Code)** act as a **Single Source of Truth** for all your infrastructure.
- **DevOps** main usecase is to reduce **time to market**, we want to make changes in **Minimum Time**, **Minimum Cost**, **Minimum Risk**.
- **Ansible** is **Agentless Configuration Management tool**, where agent is not required to be installed on managed nodes. It uses **SSH** protocol to connect and configure managed nodes.
- **Control Node** :- Where ansible is installed. This machine has IPs and SSH Keys of all managed nodes. This machine access and configure all the managed nodes using **Push based mechanism**.
- **Managed Node** :- Where changes are to be done using Ansible. These are target servers.
- **Playbook** is a set of instructions written in **YAML** files which are used to automate tasks on managed nodes.
- **Idempotency**: If we run the same playbook multiple times, it will have the same effect.
- **Configuration File** is used to configure the playbooks. This file is kept on the control node in **Default Path** `/etc/ansible/ansible.cfg`
- **Inventory** :- List of all managed nodes. These can be IP Addresses or Hostnames. **Inventory is optional**.

# Ansible Architecture
