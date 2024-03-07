IMAGE := jwasm:debian

# User Settings
TARGET_ASM := src/main.asm
GDBGUI_PORT := 8080

# Build Options
DOCKER_OPTS :=\
	--rm \
	-it \
	-v $(shell pwd):/workdir/asm \
	-p 0.0.0.0:$(GDBGUI_PORT):5000 \
	-w /workdir/asm \
	$(IMAGE)
JWASM_OTPS :=\
	-elf \
	-Zf \
	-zze \
	-zcw
GCC_OPTS :=\
	-m32 \
	-O0 \
	-ggdb
GDBGUI_OPTS :=\
	-r \
	-n

# User Commands
run: $(TARGET_ASM)
	docker run $(DOCKER_OPTS) make run.container

debug:
	docker run $(DOCKER_OPTS) make debug.container

clean:
	rm -rf main *.o

image:
	docker build -t $(IMAGE) .

# In container commands
run.container:
	make build.container
	./main

debug.container:
	make build.container
	gdbgui $(GDBGUI_OPTS) /workdir/asm/main

build.container:
	jwasm $(JWASM_OTPS) $(TARGET_ASM)
	gcc $(GCC_OPTS) -o main main.o

.PHONY: run.container debug debug.container build.container
