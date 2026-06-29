#!/bin/bash

# Update package lists and install basic Python requirements
sudo apt update -y 
sudo apt install python3-pip python3-venv -y

# Install pipx (to manage isolated Python environments)
# Also install build dependencies (rustc, cargo, libssl-dev, etc.) required to compile Python packages from source
sudo apt install pipx build-essential libssl-dev libffi-dev python3-dev pkg-config cargo rustc -y

# Clean up any existing broken or incomplete ansible installations managed by pipx
pipx uninstall ansible 2>/dev/null || true
pipx uninstall ansible-core 2>/dev/null || true

# Install the full ansible package (including its dependencies)
pipx install --include-deps ansible

# Workaround for the "Illegal instruction" crash on older CPUs:
# We force pipx to build an older version of 'cryptography' (<42) from source instead of using pre-compiled binaries. 
# Version <42 is chosen because it uses a Cargo lockfile format compatible with the default rustc version on Ubuntu 22.04.
pipx runpip ansible install "cryptography<42" --no-binary cryptography --force-reinstall

# Install ansible-core for running playbooks directly
pipx install ansible-core
pipx runpip ansible-core install "cryptography<42" --no-binary cryptography --force-reinstall

# Inject argcomplete into the ansible pipx environment to enable shell autocompletion
pipx inject --include-apps ansible argcomplete

# Ensure the pipx binary directory (~/.local/bin) is added to the shell's PATH in .bashrc/.zshrc
pipx ensurepath

# Export PATH manually for this current script session so the 'ansible' command is immediately available
export PATH="$PATH:$HOME/.local/bin"

# Verify the installation was successful
ansible --version
