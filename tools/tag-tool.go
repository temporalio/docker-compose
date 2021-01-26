package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"strings"

	"gopkg.in/yaml.v3"
)

func main() {
	var root, fileRegex string
	flag.StringVar(&root, "root", ".", "root to scan")
	flag.StringVar(&fileRegex, "file-regex", `docker-compose.*\.ya?ml`, "file prefix to process")
	var serverTag, webTag string
	flag.StringVar(&serverTag, "server-tag", "", "server images tag to set")
	flag.StringVar(&webTag, "web-tag", "", "web image tag to set")
	flag.Parse()

	serviceTags := map[string]string{
		"temporal":             serverTag,
		"temporal-admin-tools": serverTag,
		"temporal-web":         webTag,
	}

	fileRx,err := regexp.Compile(fileRegex)
	if err != nil{
		log.Fatal(err)
	}

	err = filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		if fileRx.MatchString(info.Name()) {
			composeFile, err := ioutil.ReadFile(path)
			if err != nil {
				return err
			}
			var composeStruct struct {
				Version  string
				Services map[string]map[string]interface{}
				Networks map[string]interface{}
			}
			err = yaml.Unmarshal(composeFile, &composeStruct)
			services := composeStruct.Services
			fileUpdated := false
			for serviceName, serviceCfg := range services {
				tag, ok := serviceTags[serviceName]
				if !ok || tag == "" {
					continue
				}
				imageValue := serviceCfg["image"].(string)
				imageValues := strings.Split(imageValue, ":")
				newImageValue := fmt.Sprintf("%s:%s", imageValues[0], tag)
				if imageValue != newImageValue {
					serviceCfg["image"] = newImageValue
					fileUpdated = true
				}
			}

			if !fileUpdated {
				return nil
			}

			var newComposeFile bytes.Buffer
			enc := yaml.NewEncoder(&newComposeFile)
			enc.SetIndent(2)
			err = enc.Encode(composeStruct)
			if err != nil {
				return err
			}
			err = enc.Close()
			if err != nil {
				return err
			}
			err = ioutil.WriteFile(path, newComposeFile.Bytes(), os.ModePerm)
			if err != nil {
				return err
			}
		}
		return nil
	})
	if err != nil {
		log.Fatal(err)
	}
}
