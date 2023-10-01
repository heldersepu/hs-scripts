Output of terraform apply

```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.test.null_resource.sh_test will be created
  + resource "null_resource" "sh_test" {
      + id = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + data        = (known after apply)
  + day_of_week = (known after apply)
module.test.null_resource.sh_test: Creating...
module.test.null_resource.sh_test: Provisioning with 'local-exec'...
module.test.null_resource.sh_test (local-exec): Executing: ["/bin/sh" "-c" "echo 'v2'"]
module.test.null_resource.sh_test (local-exec): v2
module.test.null_resource.sh_test: Creation complete after 0s [id=4332494558072206064]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

data = {
  "timeslot" = [
    "Saturday",
    "Sunday",
  ]
  "var1" = 2
  "version" = "v2"
}
day_of_week = "Sunday"
```