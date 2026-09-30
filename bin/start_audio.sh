#!/bin/sh

pipewire >/tmp/pipewire.log 2>&1
sleep 6
sudo modprobe -r snd_sof_pci_intel_tgl
sudo udevadm trigger --subsystem-match=sound
sudo modprobe snd_sof_pci_intel_tgl

