#!/bin/bash
sudo dnf install -y python39
sudo alternatives --set python /usr/bin/python3.9 || true
sudo ln -sf /usr/bin/python3.9 /usr/bin/python3
