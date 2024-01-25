terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.84.1"
    }
  }
}

variable "password" {
  type      = string
  sensitive = true
}

provider "snowflake" {
  account  = "rxogmnb-htb38554"
  user     = "HELDERSEPU"
  password = var.password
}

data "snowflake_database" "test" {
  name = "TEST"
}

data "snowflake_tables" "current" {
  database = data.snowflake_database.test.id
  schema   = "PUBLIC"
}

output "test" {
  value = data.snowflake_tables.current
}


resource "snowflake_table" "table" {
  database = "TEST"
  schema   = "PUBLIC"
  name     = "FOO1"

  column {
    name     = "data"
    type     = "text"
    nullable = false
  }
}

resource "snowflake_table" "FOO" {
  database = "TEST"
  schema   = "PUBLIC"
  name     = "FOO"

  column {
    name     = "ID1"
    nullable = true
    type     = "NUMBER(38,0)"
  }
  column {
    name     = "ID2"
    nullable = true
    type     = "NUMBER(38,0)"
  }
}

resource "snowflake_table" "FOO3" {
  database = "TEST"
  schema   = "PUBLIC"
  name     = "FOO3"

  column {
    name     = "ID1"
    nullable = true
    type     = "NUMBER(38,0)"
  }
  column {
    name     = "ID2"
    nullable = true
    type     = "NUMBER(38,0)"
  }
  column {
    name     = "ID3"
    nullable = true
    type     = "NUMBER(38,0)"
    default {
      expression = "CURRENT_TIMESTAMP()"
    }
  }
}