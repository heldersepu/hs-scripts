locals {
  networks = [
    { "name" : "avalan", "factor" : 99 * 0.25 },
    { "name" : "fantom", "factor" : 100 * 10 },
  ]
  methods = [
    { "name" : "A_transferOwnership", "gas" : 100 },
    { "name" : "A_deploySimpleMarkt", "gas" : 80 },
    { "name" : "B_addOneNFTContract", "gas" : 210 }
  ]

  all_keys = {
    for x in setproduct(local.networks, local.methods) : "${x[1].name}_${x[0].name}" => {
      network : x[0].name,
      group : split("_", x[1].name)[0],
      cost: x[0].factor * x[1].gas
    }
  }
}

output "mymap" {
  value = local.all_keys
}