#!/usr/bin/env bash

[[ -z $utils_loaded ]] && source ../lib/utils.sh

case "$(systemd-detect-virt)" in
    vmware)
        echo "VMWARE DETECTED"
        install open-vm-tools
        sudo systemctl enable --now vmtoolsd.service
        ;;
esac
