locals {
  networks = ["avalanche", "fantom"]
  methods = [
    "A_transferOwnership",
    "A_deploySimpleMarketplace",
    "B_addNFTContract"
  ]

  all_keys = {
    for x in setproduct(local.networks, local.methods) : "${x[1]}_${x[0]}" => {
      network : x[0],
      group : split("_", x[1])[0]
    }
  }
}

output "mymap" {
  value = local.all_keys
}