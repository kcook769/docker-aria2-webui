NAME=aria2-webui
VERSION=1.0
IMAGE_NAME=$(NAME):$(VERSION)
DATA_DIR=/usr/local/media/aria
CONTAINER_DATA_DIR=/data
EXTERNAL_HTTP_PORT=9091
build-image:
	docker build -t $(IMAGE_NAME) .

# Start a container, mounting ./src if it exists
run-foreground:
	docker run -it --rm --hostname $(NAME)-$(VERSION) -v $(DATA_DIR):/$(CONTAINER_DATA_DIR) -p $(EXTERNAL_HTTP_PORT):80 $(IMAGE_NAME)
run-daemonize:
	docker run -d --name $(NAME) --hostname $(NAME)-$(VERSION) -v $(DATA_DIR):/$(CONTAINER_DATA_DIR) -p $(EXTERNAL_HTTP_PORT):80 $(IMAGE_NAME)
