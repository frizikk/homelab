#!/usr/bin/bash

export UBUNTU_SERVER_CLOUD_IMAGE="jammy-server-cloudimg-amd64.img"
export STORAGE_POOL="local-lvm"
export VM_ID="10001"
export VM_NAME="ubuntu-22.04-cloudimg"

wget https://cloud-images.ubuntu.com/jammy/current/$UBUNTU_SERVER_CLOUD_IMAGE

apt-get install libguestfs-tools
virt-customize -a $UBUNTU_SERVER_CLOUD_IMAGE --install qemu-guest-agent

# Create Proxmox VM image from Ubuntu Cloud Image.
qm create $VM_ID  --memory 6144 --net0 virtio,bridge=vmbr0
qm importdisk $VM_ID $UBUNTU_SERVER_CLOUD_IMAGE $STORAGE_POOL
qm set $VM_ID --scsihw virtio-scsi-pci --scsi0 $STORAGE_POOL:vm-$VM_ID-disk-0
qm set $VM_ID --agent enabled=1,fstrim_cloned_disks=1
qm set $VM_ID --name $VM_NAME

# Create Cloud-Init Disk and configure boot.
qm set $VM_ID --ide2 $STORAGE_POOL:cloudinit
qm set $VM_ID --boot c --bootdisk scsi0
qm set $VM_ID --serial0 socket --vga serial0

qm template $VM_ID

rm $UBUNTU_SERVER_CLOUD_IMAGE

# Resize disk
# configure ip
