.PHONY: gogo build stop-services start-services truncate-logs bench

gogo: stop-services build truncate-logs start-services bench

build:
	make -C go build

stop-services:
	sudo systemctl stop nginx
	sudo systemctl stop isucholar.go.service
	sudo systemctl stop mysql

start-services:
	sudo systemctl start mysql
	sudo systemctl start isucholar.go.service
	sudo systemctl start nginx

truncate-logs:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo truncate --size 0 /var/log/nginx/error.log
	sudo truncate --size 0 /var/log/mysql/mysql-slow.log 

kataribe:
	cd ../ && sudo cat /var/log/nginx/access.log | ./kataribe

bench:
	sudo -u ubuntu ssh bench "sudo /home/isucon/benchmarker/bin/benchmarker -target 52.69.9.115 -tls"
