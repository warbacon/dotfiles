#!/usr/bin/env bash

# Prepare the system for using the playbooks (Arch Linux only).

sudo pacman -S ansible-core
ansible-galaxy collection install -r requirements.yml
