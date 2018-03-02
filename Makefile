build:
	cd frontend  && $(MAKE)
	cd Redis_slave && $(MAKE)
push:
	docker push 80.158.0.168:443/otc00000000001000013568/frontend:latest
	docker push 80.158.0.168:443/otc00000000001000013568/redis:3.0
	docker push 80.158.0.168:443/otc00000000001000013568/redisslave:3.0

tag:
	docker tag `docker images -q frontend` 80.158.0.168:443/otc00000000001000013568/frontend:latest
	docker tag `docker images -q redisslave` 80.158.0.168:443/otc00000000001000013568/redisslave:3.0
	docker tag `docker images -q redis:3.0` 80.158.0.168:443/otc00000000001000013568/redis:3.0

run:
	docker run -d --name redis-master redis:3.0
	docker run -d --name redis-slave --link redis-master redisslave
	docker run -d --name frontend -p 80:80 --link redis-master --link redis-slave frontend

delete:
	docker rm -f redis-master redis-slave frontend

purge:
	docker rmi 80.158.0.168:443/otc00000000001000013568/redisslave:3.0
	docker rmi 80.158.0.168:443/otc00000000001000013568/redis:3.0
	docker rmi 80.158.0.168:443/otc00000000001000013568/frontend
	docker rmi redisslave redis:3.0 frontend php:5-apache

update-notary-cert:
	openssl s_client -host 80.158.0.168 -port 4443 -showcerts| sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' >notary-server.cr
	sudo cp notary-server.cr /etc/pki/trust/anchors/notary-server.crt
	sudo cp notary-server.cr /usr/share/pki/trust/anchors/
	sudo update-ca-certificates extra 80.158.0.168
