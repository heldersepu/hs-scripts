url="https://myapp.oktapreview.com/api"

function clean() {
    resource=$(echo $1 | tr '[:upper:]' '[:lower:]')
    resource=$(echo $resource | tr -d '"')
    resource="${resource//  /_}"
    resource="${resource// /_}"
    resource="${resource/:/_}"
    resource="${resource/./_}"
    resource="${resource/@/_}"
    resource="${resource/(/_}"
    resource="${resource/)/_}"
    resource="${resource/_-_/_}"
    resource="${resource/\"_\"/_}"
    resource="${resource/__/_}"
    echo $resource
}
