k8s: k8s/temporal-default k8s/temporal-postgres k8s/temporal-mysql k8s/temporal-mysql-es k8s/temporal-cass k8s/temporal-cass-es

k8s/temporal-default: docker-compose.yml
	- rm -rf k8s/temporal-default
	mkdir -p k8s/temporal-default
	kompose convert -f docker-compose.yml -o ./k8s/temporal-default

k8s/temporal-postgres: docker-compose-postgres.yml
	- rm -rf k8s/temporal-postgres
	mkdir -p k8s/temporal-postgres
	kompose convert -f docker-compose-postgres.yml -o ./k8s/temporal-postgres

k8s/temporal-mysql: docker-compose-mysql.yml
	- rm -rf k8s/temporal-mysql
	mkdir -p k8s/temporal-mysql
	kompose convert -f docker-compose-mysql.yml -o ./k8s/temporal-mysql

k8s/temporal-mysql-es: docker-compose-mysql-es.yml
	- rm -rf k8s/temporal-mysql-es
	mkdir -p k8s/temporal-mysql-es
	kompose convert -f docker-compose-mysql-es.yml -o ./k8s/temporal-mysql-es

# kompose doesn't like on-failure:5 which is used in cockroachdb compose files.
# k8s/temporal-cockroach: docker-compose-cockroach.yml
# 	- rm -rf k8s/temporal-cockroach
# 	mkdir -p k8s/temporal-cockroach
# 	kompose convert -f docker-compose-cockroach.yml -o ./k8s/temporal-cockroach

# k8s/temporal-cockroach-es: docker-compose-cockroach-es.yml
# 	- rm -rf k8s/temporal-cockroach-es
# 	mkdir -p k8s/temporal-cockroach-es
# 	kompose convert -f docker-compose-cockroach-es.yml -o ./k8s/temporal-cockroach-es

k8s/temporal-cass: docker-compose-cass.yml
	- rm -rf k8s/temporal-cass
	mkdir -p k8s/temporal-cass
	kompose convert -f docker-compose-cass.yml -o ./k8s/temporal-cass

k8s/temporal-cass-es: docker-compose-cass-es.yml
	- rm -rf k8s/temporal-cass-es
	mkdir -p k8s/temporal-cass-es
	kompose convert -f docker-compose-cass-es.yml -o ./k8s/temporal-cass-es
