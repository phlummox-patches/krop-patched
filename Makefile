
.PHONY: build copy

NAME=phlummox/krop
TAG=0.1

build:
	docker build --file Dockerfile  -t  $(NAME):$(TAG) .

copy: build
	docker -D run --name tmp-krop-ctr $(NAME):$(TAG) true
	docker cp tmp-krop-ctr:/opt/work/krop/dist/krop .
	docker cp tmp-krop-ctr:/opt/work/krop/krop-0.5.1.deb .
	docker rm tmp-krop-ctr


