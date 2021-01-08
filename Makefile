release: update-tag tar

update-tag:
	go run tools/tag-tool.go -server-tag=$(SERVER_TAG) -web-tag=$(WEB_TAG)

tar:
	rm -f docker-compose.tar.gz
	tar -zcvf docker-compose.tar.gz docker-compose*.yml dynamicconfig/* README.md