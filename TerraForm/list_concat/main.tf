terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.33.1"
    }
  }
}

resource snowflake_role transform_roles {
  count   = 2
  name    = "role${count.index}"
  comment = "A role."
}

resource snowflake_role read_all_role {
  name    = "read role"
  comment = "A role."
}

resource snowflake_database_grant grant_db_usage_to_roles {
  for_each          = toset(concat([snowflake_role.transform_roles], [snowflake_role.read_all_role]))
  database_name     = "test"
  privilege         = "USAGE"
  roles             = [each.value.name]
  with_grant_option = false
}