IMAGE := jwasm:debian

# User Settings
GDBGUI_PORT := 8080

# Target Files
SRCS := $(wildcard src/*.asm)
OBJS := $(SRCS:.asm=.o)
OUT := a.out

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
run: $(SRCS)
	docker run $(DOCKER_OPTS) make run.container

debug:
	docker run $(DOCKER_OPTS) make debug.container

clean:
	rm -rf *.out src/*.o

image:
	docker build -t $(IMAGE) .

# In container commands
run.container:
	make build.container
	./$(OUT)

debug.container:
	make build.container
	gdbgui $(GDBGUI_OPTS) $(OUT)

build.container: $(SRCS)
	jwasm $(JWASM_OTPS) $(SRCS)
	mv *.o src/
	gcc $(GCC_OPTS) -o $(OUT) $(OBJS)

.PHONY: debug run.container debug.container
