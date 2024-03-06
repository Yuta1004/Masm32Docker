IMAGE := jwasm:debian

SRC := $(wildcard src/*.asm)

JWASM_OTPS := -elf -Zf -zze -zcw

run: $(SRC)
	docker run --rm -it -v $(shell pwd):/workdir/asm -w /workdir/asm $(IMAGE) make run.container

run.container:
	jwasm $(JWASM_OTPS) src/main.asm
	gcc -m32 -o main main.o
	./main

clean:
	rm -rf main *.o

image:
	docker build -t $(IMAGE) .

.PHONY: run.container
