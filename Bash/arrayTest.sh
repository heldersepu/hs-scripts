declare -A enviroments=( ["dev"]="qa" ["qa"]="stage" ["stage"]="prod")

if [[ ${enviroments[$1]} ]]; then
    echo "${enviroments[$1]}"
else
    echo "Not found" 
fi