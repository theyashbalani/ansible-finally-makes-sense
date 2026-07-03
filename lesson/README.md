# Ansible Overview

- **IaC (Infrastructure as Code)** act as a **Single Source of Truth** for all your infrastructure.
- **DevOps** main usecase is to reduce **time to market**, we want to make changes in **Minimum Time**, **Minimum Cost**, **Minimum Risk**.
- **Ansible** is **Agentless Configuration Management tool**, where agent is not required to be installed on managed nodes. It uses **SSH** protocol to connect and configure managed nodes.
- **Control Node** :- Where ansible is installed. This machine has IPs and SSH Keys of all managed nodes. This machine access and configure all the managed nodes using **Push based mechanism**.
- **Managed Node** :- Where changes are to be done using Ansible. These are target servers.
- **Playbook** is a set of instructions written in **YAML** files which are used to automate tasks on managed nodes. Imperative Blueprint.
- **Idempotency**: If we run the same playbook multiple times, it will have the same effect.
- **Configuration File** is used to configure the playbooks. This file is kept on the control node in **Global Path** `/etc/ansible/ansible.cfg`
- **Inventory** :- List of all managed nodes. These can be IP Addresses or Hostnames. **Inventory is optional**.
- **host file (inventory.ini)** :- File to connect control node to worker node. It contains IP addresses of all the worker nodes.
- **Dynamic Inventory** :- A system that allows Ansible to programmatically pull host and group data from external sources at runtime
- **Ansible Collection**: a distribution format for Ansible content that packages modules, plugins, roles, and playbooks. It allows for better organization, reuse, and sharing of Ansible content. It contains role files in a specific folder structure `etc/amsible/collections/`
- **Ansible Vault** :- A tool to encrypt sensitive data such as passwords, keys, and tokens.
- **Ansible Tower** :- (AWX) is a automation platform that provides additional features on top of Ansible, such as Web UI, RBAC, Inventory Management, Job Scheduling, etc.
- **Ansible Semaphore** :- Open source job scheduler and RBAC controller for Ansible. It extends Ansible with an API, a web-based UI, and role-based access control.

# Ansible Commands

- `ansible <node> -m ping` when ansible is configured globally.

  > `<node>` is name of the group of hosts in the inventory file.\
  > `-m` is module\
  > `ping` is the module to be executed.

- `ansible -i hosts all -m ping` when ansible is configured locally and inventory file is passed as an argument.

  > `-i` is for inventory file path\
  > `all` is for all the hosts in the inventory file

- `ansible -i hosts <node> -a <shell-command> -v --become` when ad-hoc command is to be executed

  > `-a` is for ad-hoc command
  > `<shell-command>` is the linux shell command to be executed on the managed nodes
  > `-v` increases the verbosity of the command
  > `--become` is used to execute the command with root privileges
  > `-k` is used to ask for the password

- `ansible -i hosts <node> -m setup -v`

  > `setup` is the module to fetch facts from the managed nodes

- `ansible-inventory -i <host_file_path> --list` (or `--graph`) to list all the hosts in the inventory file

# Ansible Playbook Commands

- `ansible-playbook playbook.yaml` when playbook is to be executed without inventory file

  > `playbook.yaml` is the name of the playbook

- `ansible-playbook -i hosts playbook.yaml --check` when playbook is to be executed with inventory file

  > `-i` is for inventory file path
  > `playbook.yaml` is the name of the playbook
  > `--check` is used to check the playbook without executing it, a dry run

# Ansible Vault Commands

- `ansible-vault encrypt <secrets-file> --vault-password-file <vault-password-file>` to encrypt a secrets file using vault password file
- `ansible-playbook -i hosts <secrets-file> --vault-password-file <vault-password-file>` when playbook is to be executed with vault password file
- `ansible-vault encrypt --ask-vault-pass <secrets-file>` to encrypt a secrets file by asking for the vault password
- `ansible-vault decrypt --ask-vault-pass <secrets-file>` to decrypt a secrets file by asking for the vault password

# Ansible Roles

- **Roles** :- Ansible roles allow you to organize and reuse Ansible playbooks. They create a ready to use template for other users to use your playbook
- **Ansible Galaxy** :- Community marketplace for Ansible Roles.
- **default**: default variables
- **tasks**: list of tasks to be executed
- **handlers**: run when task notify, to handle service restarts
- **templates**: to create dynamic files, jinja templates
- **vars**: variables
- **files**: to copy paste files
- **meta**: meta data about the role

```
├── README.md
├── defaults
│ └── main.yml
├── files
├── handlers
│ └── main.yml
├── meta
│ └── main.yml
├── tasks
│ └── main.yml
├── templates
├── tests
│ ├── inventory
│ └── test.yml
└── vars
  └── main.yml
```

# Ansible Galaxy Commands

- `ansible-galaxy init roles/<roles-name>` To create a roles directory
