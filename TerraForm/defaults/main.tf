terraform {
  experiments = [module_variable_optional_attrs]
}

module "test" {
  source = "./testmod"
  network_acls = {
    "allowTrafficOfficeIPOutbound" = {
      direction = "Outbound"
      access    = "Allow"
    }
    "allowTrafficOfficeIPInbound" = {
      direction = "Inbound"
    }
  }
}