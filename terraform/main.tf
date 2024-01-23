resource "openstack_compute_keypair_v2" "my_cloud_keys" {
  name       = "new_ex05keys"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRgat3ljnAWkjt1zve8iYwAJEM4bELx4vtj8QpZruXmeHM9bzCKMQMxXkqV9Cv5kZZkQJMDfC1u5CP8mpebFCmExaW9YUeqglgcc3rkFSrIyNmG30Wj7VcUpzqBqWojdXQyirgKzdq1YGyJ5iKj8gsE/M3RUSGuL976/gzcuxpqMPAJQMEIPenvMY4eBNDW14UId2Aequ6VKT57MZT1t8k0xFCD4FAT50wgk270UtT/Vk+IGSvPPrXY+dyQW/7cXv9unBDq5tTFKo6lr8XQJhZUddfL8D8kaLOxDq84ErztGlyS8BovphzesGbGNWIc3306mQhBXJGRL5LPm5qIxB1"
}


resource "openstack_compute_instance_v2" "VM1" {
  name            = "VM1"
  image_name      = "CentOS-8-stream"
  flavor_name     = "standard.small"
  key_pair        = "${openstack_compute_keypair_v2.my_cloud_keys.name}"
  security_groups = ["secgroup_1"]

  network {
    name = "project_2008924"
  }
}


resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public"

}


resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.VM1.id
}



resource "openstack_compute_instance_v2" "VM" {
  name            = "VM-${count.index + 2 }"
  image_name      = "CentOS-8-stream"
  flavor_name     = "standard.small"
  key_pair        = "${openstack_compute_keypair_v2.my_cloud_keys.name}"
  security_groups = ["secgroup_2"]
  count = 3

  network {
    name = "project_2008924"
  }
}

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "secgroup_1"
  description = "Security Group 1"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_2" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_3" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "192.168.1.0/24"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}


resource "openstack_networking_secgroup_v2" "secgroup_2" {
  name        = "secgroup_2"
  description = "Security Group 2"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_4" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 1
  port_range_max    = 65535
  remote_ip_prefix  = "192.168.1.0/24"
  security_group_id = openstack_networking_secgroup_v2.secgroup_2.id
}
