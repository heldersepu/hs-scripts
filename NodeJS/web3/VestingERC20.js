const Web3 = require("web3")
const abi = require("./abi.json")

async function getVestedAmount() {
    const web3Provider = new Web3.providers.HttpProvider(process.env.provider)
    const web3 = new Web3(web3Provider)
    let contract = new web3.eth.Contract(abi, process.env.contract)
    let data = await contract.methods.getVestedAmount().call((err, result) => {
        return result
    })
    return data
}

getVestedAmount().then(console.log)