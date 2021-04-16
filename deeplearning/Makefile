CONTAINER_NAME = mtangemann/deeplearning

.PHONY: latest
latest: v3
	sudo docker tag $(CONTAINER_NAME):v3 $(CONTAINER_NAME):latest

.PHONY: v3
v3: 
	sudo docker build . -t $(CONTAINER_NAME):v3
