k8s/temporal/*.yaml: docker-compose.yml
	rm k8s/temporal/*.yaml
	kompose convert -f docker-compose.yml -o ./k8s/temporal