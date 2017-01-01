# echo

echo prints the first positional argument to stdout.

## Usage

```
echo foo
```

## Build

The following steps work on Linux machines.

Compile:

```
nasm -f elf32 echo.asm
```

Link:

```
ld -m elf_i386 -s -o echo echo.o
```
