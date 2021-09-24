all: run

test:
	helm chart save chart/ harbor.onwalk.net/charts/rust-axum-demo

build: 
	docker build --network host -t axum-web:latest .
run: build
	docker run -d -t -i --network host --name axum-web axum-web 
clean:
	make -C guess_game clean
	make -C axum-web clean
