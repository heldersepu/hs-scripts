variable PETS {
  type = map
  default = {
    "dog" = {
      indoor  = "poodle"
      outdoor = "labrador"
      others  = "bulldog"
    },
    "cat" = {
      indoor  = "siamese"
      outdoor = "persian"
      others  = "bengal"
    }
  }
}

variable TYPE {
  type = string
}

variable BREED {
  type = string
}


output "TYPE_BREED" {
  value = var.PETS[var.TYPE][var.BREED]
}
