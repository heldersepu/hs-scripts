locals {
  networks = [
    { name : "avalan", factor : 25 * 30000000001 / 1000000000000000000 },
    { name : "fantom", factor : 321 * 5000000000 / 1000000000000000000 },
  ]
  methods = [
    { name : "A_transferOwnership", gas : 47000 },
    { name : "A_deploySimpleMarkt", gas : 2700000 },
    { name : "B_addOneNFTContract", gas : 3000000 }
  ]

  all_keys = {
    for x in setproduct(local.networks, local.methods) : "${x[1].name}_${x[0].name}" => {
      network : x[0].name,
      group : split("_", x[1].name)[0],
      cost : format("%.4f", x[0].factor * x[1].gas)
    }
  }
}

output "mymap" {
  value = local.all_keys
}