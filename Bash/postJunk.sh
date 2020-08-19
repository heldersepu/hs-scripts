for i in $(seq 1000 1 9000); do
  curl -H 'Content-Type: application/json' \
    -d "{\"email\":\"loadjunk$i@gmail.com\",\"password\":\"22345asdf$i\",\"username\":\"loadjunk$i\"}" \
    -X POST https://piano-gym-api-production.herokuapp.com/api/v1/sign_up/
  echo ""
done