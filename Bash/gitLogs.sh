add_git_metadata_message() {
  local message=$(git log -1 --format=format:%B | head -c 10240 | jq -s -R .)

  jq ". + [
    {name: \"message\", value: ${message}, type: \"message\"}
  ]"
}


jq -n "[]" | \
add_git_metadata_message
