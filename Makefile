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
