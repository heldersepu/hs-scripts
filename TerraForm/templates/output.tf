output "var_template" {
  value = data.template_file.user_data2.*.rendered
}
