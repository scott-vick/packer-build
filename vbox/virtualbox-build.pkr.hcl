variable "guest_os_type" {default = "RedHat_64"}
variable "headless" {default = "false"}
variable "base_directory" {default = "/home/user1/packer/vbox"}
variable "iso_directory" {default = "/home/user1/packer/iso"}
variable "ssh_private_key_file" {default = "~/packer/vbox/.keys/packer_rsa"}
variable "ssh_timeout" {default = "20m"}
variable "RHSMPassword" {}

source "virtualbox-iso" "rhel7" {
    boot_command            = [
        "<esc><wait>linux inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/vbox-rhel7-ks.cfg ip=dhcp <enter><wait>"
    ]
    vm_name                 = "rhel7-vagrant"
    cpus                    = "1"
    memory                  = "1024"
    disk_size               = "61440"
    guest_additions_mode    = "disable"
    shutdown_command        = "sudo shutdown -P now"
    ssh_username            = "vagrant"
    ssh_password            = "vagrant"
    ssh_private_key_file    = var.ssh_private_key_file
    ssh_timeout             = var.ssh_timeout
    guest_os_type           = var.guest_os_type
    headless                = var.headless
    http_directory          = var.base_directory
    iso_checksum            = "f9a8af0fa024a5d41cce9c7bf131a1bda96ed8c4"
    iso_url                 = "${var.iso_directory}/rhel-server-7.9-x86_64-dvd.iso"
    output_directory        = "${var.base_directory}/vagrant-rhel7-build"
    vboxmanage              = [
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"], 
        ["createhd", "--format", "VMDK", "--filename", "rhel7-vagrant-disk002.vmdk", "--size", "8194"], 
        ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "rhel7-vagrant-disk002.vmdk"]
    ]
}

source "virtualbox-iso" "rhel8" {
    boot_command            = [
        "<esc><wait>linux inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/vbox-rhel8-ks.cfg ip=dhcp <enter><wait>"
    ]
    vm_name                 = "rhel8-vagrant"
    cpus                    = "1"
    memory                  = "1024"
    disk_size               = "61440"
    guest_additions_mode    = "disable"
    shutdown_command        = "sudo shutdown -P now"
    ssh_username            = "vagrant"
    ssh_password            = "vagrant"
    ssh_private_key_file    = var.ssh_private_key_file
    ssh_timeout             = var.ssh_timeout
    guest_os_type           = var.guest_os_type
    headless                = var.headless
    http_directory          = var.base_directory
    iso_checksum            = "9d8a8d4f4a512f4dcd695f8b29fb88a2ef2e4a84"
    iso_url                 = "${var.iso_directory}/rhel-8.2-x86_64-dvd.iso"
    output_directory        = "${var.base_directory}/vagrant-rhel8-build"
    vboxmanage              = [
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"], 
        ["createhd", "--format", "VMDK", "--filename", "rhel8-vagrant-disk002.vmdk", "--size", "8194"], 
        ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "rhel8-vagrant-disk002.vmdk"]
    ]
}

source "virtualbox-iso" "rhel9" {
    boot_command            = [
        "<esc><wait>linux inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/vbox-rhel9-ks.cfg ip=dhcp <enter><wait>"
    ]
    vm_name                 = "rhel9-vagrant"
    cpus                    = "1"
    memory                  = "1024"
    disk_size               = "61440"
    guest_additions_mode    = "disable"
    shutdown_command        = "sudo shutdown -P now"
    ssh_username            = "vagrant"
    ssh_password            = "vagrant"
    ssh_private_key_file    = var.ssh_private_key_file
    ssh_timeout             = var.ssh_timeout
    guest_os_type           = var.guest_os_type
    headless                = var.headless
    http_directory          = var.base_directory
    iso_checksum            = "bc36a3a46082c47eeeac489889eab5df2f5d62cb"
    iso_url                 = "${var.iso_directory}/rhel-9.0-x86_64-dvd.iso"
    output_directory        = "${var.base_directory}/vagrant-rhel9-build"
    vboxmanage              = [
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"], 
        ["createhd", "--format", "VMDK", "--filename", "rhel9-vagrant-disk002.vmdk", "--size", "8194"], 
        ["storageattach", "{{.Name}}", "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", "rhel9-vagrant-disk002.vmdk"]
    ]
}

build {
    description = "Packer template to build RHEL VM and deploy it to Vagrant"

    sources = [
        "source.virtualbox-iso.rhel7",
        "source.virtualbox-iso.rhel8",
        "source.virtualbox-iso.rhel9"
    ]

    provisioner "shell" {
        inline = [
            "mkdir ~vagrant/.ssh",
            "echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC4aVlo1VkhPow4qUtDOIb+yoS0FNiWmLXLvXtWKzm+mL4kpo1Rod/zm8HcosIuADwSXj3V9pHGGceoxZ9tBC8v52JbmOCc+Y4uWNDovZ4pWpNoylZFHFm1YLkJc6IthKPdru0ZNTc2HL0nE61sKT31PpSyJxDjJ10O/NcfMI2KaUeRI/TO4yTmeClk56h+/Q98PQHPZONUUHFPInIgc5SfjymnP4h1th0R8Rs9yy247gB0RyjKHm3W4kM34oJD5+560jPwhyjW9BnAhbSByCkQzOVyMejKoNdX+x0uzBfcxAm7f/WHYtSZAL9ug/ctT/PCrn7+La5zIy1TeI+kDstDslEr60p02pLgvCoGY342h9EyuQRaaNZIFF9gc0i9wvanetNjKPhtBJR3gfXEMO+oozdocdMkY3J0hEsXNW8sax1FBPjZWlARW1vTcg7SavtXC408hVMfooWVK0XTcihMIlcMwJl3osUIUpmzPTmHvrTkRPazGtObZyIJeevaHc1Cyxw0/N0CfKSVgd52l4TJvlx8V5MVPMJN56HTtXajxl1xV3RgOzpeO8+AV5qolvpl50MfhXNlC+0zi1n09Hj+ubd16WPi5eRfauIDlx4RowIfP6JHYnNAfr8AIxUrhIRPtuPHzqlC7U3YCegz0uk9JdJq4dq7uurCV0CgGBdQFw== build@vagrant' > ~vagrant/.ssh/authorized_keys",
            "chmod 700 ~vagrant/.ssh",
            "chmod 600 ~vagrant/.ssh/authorized_keys"
        ]
    }

    provisioner "ansible" {
        only = ["virtualbox-iso.rhel7"]
        user = "vagrant"
        use_proxy = false
        playbook_file   = "packer-ansible/vagrant_provision_playbook.yml"
        extra_arguments = ["-e", "rhsm_password=${var.RHSMPassword} rhsm_package_version=1.24.48-1.el7_9 os_release=7.9"]
    }
    provisioner "ansible" {
        only = ["virtualbox-iso.rhel8"]
        user = "vagrant"
        use_proxy = false
        playbook_file   = "packer-ansible/vagrant_provision_playbook.yml"
        extra_arguments = ["-e", "rhsm_password=${var.RHSMPassword} rhsm_package_version=1.28.13-2.el8 os_release=8.2"]
    }
    provisioner "ansible" {
        only = ["virtualbox-iso.rhel9"]
        user = "vagrant"
        use_proxy = false
        playbook_file   = "packer-ansible/vagrant_provision_playbook.yml"
        extra_arguments = ["-e", "rhsm_password=${var.RHSMPassword} os_release=9.0"]
    }

    post-processor "vagrant" {
        only = ["virtualbox-iso.rhel7"]
        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel7.box"
    }
    post-processor "vagrant" {
        only = ["virtualbox-iso.rhel8"]
        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel8.box"
    }
    post-processor "vagrant" {
        only = ["virtualbox-iso.rhel9"]
        output = "/home/user1/vagrant/boxes/{{ .Provider }}-rhel9.box"
    }
}

