#!/bin/bash

printf "\033[1;33m[+] Assembling With Nasm...\033[0m\n"
nasm -f elf32 -o $1.o $1.asm

printf "\033[1;33m[+] Linking...\033[0m\n"
ld -o $1 $1.o

printf "\033[1;33m[+] Object Dump in Intel format..\033[0m\n"
echo '-------------------------------------------------------------------------------------'
objdump -d ./$1 -M intel
echo '-------------------------------------------------------------------------------------'
printf '\n\n'

printf "\033[1;33m[+] Object Dump for shellcode..\033[0m\n"
echo '-------------------------------------------------------------------------------------'
objdump -d ./$1|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'
echo '-------------------------------------------------------------------------------------'

printf '\n\n'

printf "\033[1;33m[+] Done!!!\033[0m\n"
