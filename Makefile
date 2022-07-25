k8s: k8s/temporal.yaml k8s/temporal-postgres.yaml k8s/temporal-mysql.yaml k8s/temporal-mysql-es.yaml k8s/temporal-cass.yaml k8s/temporal-cass-es.yaml

k8s/temporal.yaml: docker-compose.yml
	kompose convert -f $< -o $@
	yq -i '(.items.[] | select(.kind == "Deployment") | .spec.template.spec.enableServiceLinks) = false' $@

k8s/temporal-%.yaml: docker-compose-%.yml
	kompose convert -f $< -o $@
	yq -i '(.items.[] | select(.kind == "Deployment") | .spec.template.spec.enableServiceLinks) = false' $@
