release: update-tag

update-tag:
	go run tools/tag-tool.go -server-tag=$(SERVER_TAG) -web-tag=$(WEB_TAG)
