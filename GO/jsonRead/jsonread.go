package main

import (
	"encoding/json"
	"fmt"
)

type ExtraVars struct {
	Name   string
	Region string
}

func main() {
	var input string = "{\"name\":\"vm1\",\"region\":\"abc\"}"
	var output ExtraVars
	err := json.Unmarshal([]byte(input), &output)

	if err != nil {
		fmt.Println(err.Error())
	} else {
		fmt.Println(output.Name)
	}
}
