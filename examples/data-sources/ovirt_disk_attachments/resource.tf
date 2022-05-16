resource "ovirt_disk" "test1" {
  storagedomain_id = var.storagedomain_id
  format           = "raw"
  size             = 1048576
  alias            = "test"
  sparse           = true
}

resource "ovirt_disk" "test2" {
  storagedomain_id = var.storagedomain_id
  format           = "raw"
  size             = 1048576
  alias            = "test"
  sparse           = true
}

resource "ovirt_vm" "test" {
  cluster_id  = var.cluster_id
  template_id = "00000000-0000-0000-0000-000000000000"
  name        = "test"
}

resource "ovirt_disk_attachments" "test" {
  vm_id          = ovirt_vm.test.id

  attachment {
    disk_id        = ovirt_disk.test1.id
    disk_interface = "virtio_scsi"
  }
  attachment {
    disk_id        = ovirt_disk.test2.id
    disk_interface = "virtio_scsi"
  }

  depends_on = [
    ovirt_vm.test, ovirt_disk.test1, ovirt_disk.test2
  ]
}
