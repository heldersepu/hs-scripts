variable "base_name" {
  default = "foo"
}

variable "region"{
  default ="us-east-1"
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = ["/home/heldersepu/.aws/credentials"]
}

resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.2.0/24"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "app" {
  count                   = 2
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.2.${count.index*64}/26"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

resource "aws_db_subnet_group" "app" {
  name = "test"
  subnet_ids = aws_subnet.app.*.id
}

resource "aws_rds_cluster" "test_db_cluster" {
  cluster_identifier          = var.base_name
  engine                      = "aurora-postgresql"
  engine_mode                 = "provisioned"
  engine_version              = "16.1"
  database_name               = "test"
  master_username             = "test"
  skip_final_snapshot         = true
  storage_encrypted           = true
  manage_master_user_password = true
  db_subnet_group_name        = aws_db_subnet_group.app.name
  source_region               = var.region

  serverlessv2_scaling_configuration {
    max_capacity = 1.0
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "test_db_instance" {
  identifier                   = "${var.base_name}-instance-1"
  cluster_identifier           = aws_rds_cluster.test_db_cluster.id
  instance_class               = "db.serverless"
  engine                       = aws_rds_cluster.test_db_cluster.engine
  engine_version               = aws_rds_cluster.test_db_cluster.engine_version
  performance_insights_enabled = true
}

resource "aws_rds_cluster" "read_db_cluster" {
  cluster_identifier            = "${var.base_name}-read-replica"
  engine                        = "aurora-postgresql"
  engine_mode                   = "provisioned"
  engine_version                = "16.1"
  skip_final_snapshot           = true
  storage_encrypted             = true
  db_subnet_group_name          = aws_db_subnet_group.app.name
  replication_source_identifier = aws_rds_cluster.test_db_cluster.arn
  source_region                 = var.region
}