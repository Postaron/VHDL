#!/bin/bash
#export PATH=$PATH:/usr/bin
#export PATH=$PATH:/opt/Xilinx/14.5/ISE_DS/ISE/bin/lin64
#export PATH=$PATH:/usr/bin:/opt/Xilinx/11.1/ISE/bin/lin
cp ../microcontroleur.bit ./
avr-gcc -mmcu=attiny861 -Wall -Os -c linefollow1.c
avr-gcc -mmcu=attiny861 -o linefollow1.elf -Wl,-Map,linefollow1.map linefollow1.o
avr-objdump -h -S linefollow1.elf > linefollow1.lss
data2mem -bm attiny861.bmm -bd linefollow1.elf -bt microcontroleur.bit -o uh microcontroleur
#djtgcfg prog -d Nexys3 --index 0 --file microcontroleur_rp.bit
#djtgcfg prog -d  DCabUsb --index 0 --file top_rp.bit
#djtgcfg prog -d  Basys2 --index 0 --file microcontroleur_rp.bit
