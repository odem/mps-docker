.PHONY: help all rebuild clean push start stop exec vnc

STAGE ?= bootstrap
PORT ?=5901
OPT_RUN_DOCKER ?=-d
IMAGENAME :=mpsimg.$(STAGE)
CONTNAME :=mpscnt.$(STAGE)

help:
	@echo ""
	@echo "Usage: make [PARAM=VALUE] [TARGET]"
	@echo ""
	@echo "  TARGETS"
	@echo "       all    : rebuild start and exec"
	@echo "       rebuild: clean and build"
	@echo "       clean  : Removes generated image"
	@echo "       build  : Builds the entire image from scratch"
	@echo "       start  : Starts a container from the generateed image"
	@echo "       stop   : Stop a running container"
	@echo "       exec   : Executes command within running container"
	@echo "       vnc    : Connects a running container via vnc (desktop only)"
	@echo "       push   : push STAGE image to dockerhub"
	@echo "       help   : This help message"
	@echo "  PARAMS"
	@echo "       STAGE          : The scripts to execute (boot,term,dsk)"
	@echo "       PORT           : The port to connect via vnc"
	@echo "       OPT_RUN_DOCKER : Optionas passed to docker on start"
	@echo ""

all: | rebuild start exec
rebuild: | clean build
clean: stop
	-docker rmi $(IMAGENAME)
build:
	docker build --force-rm --no-cache=true \
		-f Dockerfile.$(STAGE) -t $(IMAGENAME) .
	docker tag $(IMAGENAME):latest livemps/mps-$(STAGE)
push:
	docker push livemps/mps-$(STAGE)

start:
	docker run $(OPT_RUN_DOCKER) -p 127.0.0.1:$(PORT):$(PORT) \
		--rm --name $(CONTNAME) $(IMAGENAME)
stop:
	-docker kill $(CONTNAME)
exec:
	docker exec -it $(CONTNAME) bash
vnc:
	remmina vnc://user1234:NzATSr7ADWuuX09l+J8kng==@127.0.0.1:$(PORT) &

