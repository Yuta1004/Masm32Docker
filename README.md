# Masm32 on Docker

## Requires

- `make`
- `Docker`

## Command

### Setup(once)

```
$ make image
```

### Run

```
$ make run
```

### Debug

```
// default (localhost:8080)
$ make debug

// with port option
$ make debug GDBGUI_PORT=xxxx
```
