.PHONY: all

STAGE ?= bootstrap
IMAGENAME :=mpsimg.$(STAGE)
CONTNAME :=mpscnt.$(STAGE)
PORT :=5901
OPT_RUN_DOCKER ?=-d

all: | rebuild start exec
rebuild: | clean build
clean: stop
	-docker rmi $(IMAGENAME)
build:
	docker build --force-rm --no-cache=true \
		-f Dockerfile.$(STAGE) -t $(IMAGENAME) .
	docker tag $(IMAGENAME):latest livemps/mps-$(STAGE)
start:
	docker run $(OPT_RUN_DOCKER) -p 127.0.0.1:$(PORT):$(PORT) \
		--rm --name $(CONTNAME) $(IMAGENAME)
stop:
	-docker kill $(CONTNAME)
exec:
	docker exec -it $(CONTNAME) bash
vnc:
	remmina vnc://user1234:NzATSr7ADWuuX09l+J8kng==@127.0.0.1:$(PORT) &

