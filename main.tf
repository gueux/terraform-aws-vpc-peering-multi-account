locals {
  enabled = var.enabled == "true"
  count   = local.enabled ? 1 : 0
}

resource "null_resource" "await_active_peering" {
  count = "${var.await_peering > 0 ? 1 : 0}"

  provisioner "local-exec" {
    command = "sleep ${var.await_peering}"
  }

  triggers = {
    peering = "${join("", aws_vpc_peering_connection.requester.*.id)}"
  }
}
