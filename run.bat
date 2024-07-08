@echo off
nasm -f win64 asmfunc.asm -o asmfunc.obj

gcc -o main main.c asmfunc.obj -std=c99

del asmfunc.obj

main.exe

del main.exe

pause