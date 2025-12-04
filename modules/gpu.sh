#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

case "$(systemd-detect-virt)" in
    vmware)
        install open-vm-tools gtkmm3
        sudo systemctl enable --now vmtoolsd.service vmware-vmblock-fuse.service
        return
        ;;
esac

install vulkan-radeon rocm-smi-lib
