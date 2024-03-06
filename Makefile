IMAGE := jwasm:debian

SRC := $(wildcard src/*.asm)

DOCKER_OPTS := --rm -it -v $(shell pwd):/workdir/asm -w /workdir/asm $(IMAGE)
JWASM_OTPS := -elf -Zf -zze -zcw
GCC_OPTS := -m32

run: $(SRC)
	docker run $(DOCKER_OPTS) make run.container

run.container:
	jwasm $(JWASM_OTPS) src/main.asm
	gcc $(GCC_OPTS) -o main main.o
	./main

clean:
	rm -rf main *.o

image:
	docker build -t $(IMAGE) .

.PHONY: run.container
