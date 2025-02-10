ARMGNU ?= aarch64-linux-gnu

AOPS = --warn --fatal-warnings

asm : kernel.img

all : asm

clean :
	rm -f *.o
	rm -f *.img
	rm -f *.hex
	rm -f *.elf
	rm -f *.list
	rm -f *.img
	rm -f memory_map.txt

main.o : main.s
	$(ARMGNU)-as -g $(AOPS) main.s -o main.o


kernel.img : memmap main.o
	$(ARMGNU)-ld main.o -T memmap -o main.elf -M > memory_map.txt
	$(ARMGNU)-objdump -D main.elf > main.list
	$(ARMGNU)-objcopy main.elf -O ihex main.hex
	$(ARMGNU)-objcopy main.elf -O binary kernel.img

runQEMU : 
	qemu-system-aarch64 -s -S -machine virt -cpu cortex-a53 -machine type=virt -nographic -smp 1 -m 64 -kernel kernel.img

runGDB: 
	gdb-multiarch -ex "set architecture aarch64" -ex "target remote localhost:1234" -ex 'set confirm off' -ex 'add-symbol-file main.elf' -ex 'break exit' -ex 'continue' -ex "dashboard registers -style list 'd5'" -ex 'x/10fg 0x40080120'
