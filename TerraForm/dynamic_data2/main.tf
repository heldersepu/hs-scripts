variable "input_data" {
  default = [
    {
      "resource_app_id" : "62ec2d38-2d53-4204-989b-053a65534873",
      "id" : "b43b06f7-92d1-0a98-bcc5-b6d13557fafd", "type" : "Role",
    },
    {
      "resource_app_id" : "62ec2d38-2d53-4204-989b-053a65534873",
      "id" : "019aa34d-20ce-f301-586c-c5a1cbe410cf", "type" : "Role",
    },
    {
      "resource_app_id" : "193b6dcb-1323-4f56-8dc5-eed6f9a2789e",
      "id" : "c72de1fc-b40d-4bfc-a08a-79a23c486cc7", "type" : "Role",
    },
  ]
}

locals {
  distinct_resources = distinct(flatten([
    for key, value in var.input_data : [
      value.resource_app_id
    ]
  ]))

  output_data = flatten([
    for key, value in local.distinct_resources : {
      "resourceAppId" = value,
      "resourceAccess" : distinct([
        for k, v in var.input_data : {
          "id" : v.id, "type" : v.type
        } if v.resource_app_id == value
      ])
    }
  ])
}

output "requiredResourceAccess" {
  value = local.output_data
}
