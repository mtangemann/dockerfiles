CONTAINER_NAME = mtangemann/deeplearning-base

.PHONY: latest
latest: v1
	sudo docker tag $(CONTAINER_NAME):v1 $(CONTAINER_NAME):latest

.PHONY: v1
v1: v1-ubuntu18.04-cuda11.1-python3.8
	sudo docker tag $(CONTAINER_NAME):v1-ubuntu18.04-cuda11.1-python3.8 $(CONTAINER_NAME):v1

.PHONY: v1-ubuntu18.04-cuda11.1-python3.8
v1-ubuntu18.04-cuda11.1-python3.8:
	sudo docker build . -t $(CONTAINER_NAME):v1-ubuntu18.04-cuda11.1-python3.8
