provider "aws" {
  region = "us-east-2"
}

locals {
  rds_aurora = [
    {
      cluster_identifier     = "aurora-cluster-mysql-qa"
      cluster_instance_count = 2
      engine                 = "aurora-mysql"
      engine_version         = "5.7.mysql_aurora.2.07.1"
    },
    {
      cluster_identifier     = "aurora-cluster-mysql-dev"
      cluster_instance_count = 1
      engine                 = "aurora-mysql"
      engine_version         = "5.7.mysql_aurora.2.07.1"
    }
  ]
  data = { for i in flatten([
    for x in local.rds_aurora :
    [
      for y in range(x.cluster_instance_count) :
      {
        "id"                     = y
        "cluster_identifier"     = x.cluster_identifier
        "cluster_instance_count" = 2
        "engine"                 = x.engine
        "engine_version"         = x.engine_version
      }
    ]
    ]) : "${i.cluster_identifier}_${i.id}" => i
  }
}

output "new_data" {
  value = local.data
}