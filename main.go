package main

import (
	"os"

	"github.com/linuxsuren/atest-ext-store-etcd/cmd"
)

func main() {
	if err := cmd.NewRootCommand().Execute(); err != nil {
		os.Exit(1)
	}
}
