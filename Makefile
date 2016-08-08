build:
	cd frontend  && $(MAKE)
	cd Redis_slave && $(MAKE)
push:
	docker push 160.44.200.121:443/otc00000000001000000204/frontend:latest
	docker push 160.44.200.121:443/otc00000000001000000204/redis:3.0
	docker push 160.44.200.121:443/otc00000000001000000204/redisslave:3.0

tag:
	docker tag `docker images -q frontend` 160.44.200.121:443/otc00000000001000000204/frontend:latest
	docker tag `docker images -q redisslave` 160.44.200.121:443/otc00000000001000000204/redisslave:3.0
	docker tag `docker images -q redis:3.0` 160.44.200.121:443/otc00000000001000000204/redis:3.0

run:
	docker run -d --name redis-master redis:3.0
	docker run -d --name redis-slave --link redis-master redisslave
	docker run -d --name frontend -p 80:80 --link redis-master --link redis-slave frontend

delete:
	docker rm -f redis-master redis-slave frontend

purge:
	docker rmi 160.44.200.121:443/otc00000000001000000204/redisslave:3.0
	docker rmi 160.44.200.121:443/otc00000000001000000204/redis:3.0
	docker rmi 160.44.200.121:443/otc00000000001000000204/frontend
	docker rmi redisslave redis:3.0 frontend php:5-apache

