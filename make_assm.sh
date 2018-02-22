
#!/bin/bash

nasm -g -f elf64 -w+all -o 1.o 1.s
gcc -m64 -g -Wall -o run 1.o

