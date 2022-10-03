resource "aws_customer_gateway" "gate" {
  count      = var.vpn_enabled
  bgp_asn    = 65533
  ip_address = "172.83.124.10"
  type       = "ipsec.1"

  tags = {
    Name = "the gate"
  }
}

resource "aws_vpn_gateway" "west" {
  count = var.vpn_enabled

  tags = {
    Name = "west_vpn_gateway"
  }
}

resource "aws_vpn_connection" "west" {
  count               = var.vpn_enabled
  vpn_gateway_id      = aws_vpn_gateway.west[0].id
  customer_gateway_id = aws_customer_gateway.gate[0].id
  type                = "ipsec.1"

  tags = {
    Name = "The VPN West"
  }
}

resource "aws_vpn_gateway" "east" {
  count = var.vpn_enabled

  tags = {
    Name = "east_vpn_gateway"
  }
}

resource "aws_vpn_connection" "east" {
  count               = var.vpn_enabled
  vpn_gateway_id      = aws_vpn_gateway.east[0].id
  customer_gateway_id = aws_customer_gateway.gate[0].id
  type                = "ipsec.1"

  tags = {
    Name = "The VPN East"
  }
}
