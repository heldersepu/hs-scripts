resource "aws_customer_gateway" "gate" {
  bgp_asn    = 65533
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags {
    Name = "the gate"
  }
}

resource "aws_vpn_gateway" "west" {
  tags = {
    Name = "west_vpn_gateway"
  }
}

resource "aws_vpn_connection" "west" {
  count               = "${var.vpn_enabled}"
  vpn_gateway_id      = "${aws_vpn_gateway.west.id}"
  customer_gateway_id = "${aws_customer_gateway.gate.id}"
  type                = "ipsec.1"

  tags {
    Name = "The VPN West"
  }
}

resource "aws_vpn_gateway" "east" {
  tags = {
    Name = "east_vpn_gateway"
  }
}

resource "aws_vpn_connection" "east" {
  count               = "${var.vpn_enabled}"
  vpn_gateway_id      = "${aws_vpn_gateway.east.id}"
  customer_gateway_id = "${aws_customer_gateway.gate.id}"
  type                = "ipsec.1"

  tags {
    Name = "The VPN East"
  }
}
