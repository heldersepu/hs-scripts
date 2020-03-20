add_git_metadata_message() {
  local message=$(git log -1 --format=format:%B | cut -c 1-256 | jq -s -R .)

  jq ". + [
    {name: \"message\", value: ${message}, type: \"message\"}
  ]"
}


jq -n "[]" | \
add_git_metadata_message 
    