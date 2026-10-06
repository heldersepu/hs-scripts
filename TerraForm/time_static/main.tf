resource "time_static" "start" {
  triggers = { x = timestamp() }
}

output "current_time" {
  value = time_static.start.unix
}

resource "null_resource" "name" {
  triggers = { x = timestamp() }
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      echo "test"
      for i in {1..25}; do
        timestamp=$(date +%s)
        difference=$((timestamp - ${time_static.start.unix}))
        if [ $difference -ge 25 ]; then
          echo "past 15"
          break
        fi
        sleep 1
      done
      echo "done"
    EOT
  }
}