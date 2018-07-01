resource "aws_vpn_gateway" "dxconn" {
  tags = {
    Name        = "Direct Connect"
    Terraformed = "true"
  }
}

resource "aws_customer_gateway" "gate" {
  bgp_asn    = 65533
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags {
    Name        = "the gate"
    Terraformed = "true"
  }
}

resource "aws_vpn_connection" "west" {
  vpn_gateway_id      = "${aws_vpn_gateway.dxconn.id}"
  customer_gateway_id = "${aws_customer_gateway.gate.id}"
  type                = "ipsec.1"

  tags {
    Name        = "Backup VPN West"
    Terraformed = "true"
  }
}

resource "aws_vpn_connection" "east" {
  vpn_gateway_id      = "${aws_vpn_gateway.dxconn.id}"
  customer_gateway_id = "${aws_customer_gateway.gate.id}"
  type                = "ipsec.1"

  tags {
    Name        = "Backup VPN East"
    Terraformed = "true"
  }
}
