locals {
  ou_config = yamldecode(file("employees.yaml"))

  expanded_names = flatten([
    for e in local.ou_config.Employees : [
      for d in e.Department : [
        for key, person in d : [
          for key, value in person : [
            value.details
          ]
        ] if key == "Dev"
      ]
    ]
  ])
}

output "test" {
  value = local.expanded_names
}

output "Employees_Department" {
  value = yamldecode(file("employees.yaml")).Employees[0].Department[0]
}