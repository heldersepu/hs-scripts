try {
    throw new Error('test')
} catch (error) {
    if (error.response?.data?.detail.includes("request was invalid")) {
        console.log("invalid detected")
    }
    console.log(error)
}