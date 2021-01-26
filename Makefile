release: update-tag

update-tag:
	cd tools && go run tag-tool.go -root=.. -server-tag=$(SERVER_TAG) -web-tag=$(WEB_TAG)
