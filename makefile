all: virus
virus : skeleton.o 
	ld -melf_i386 skeleton.o  -o virus
skeleton.o: skeleton.s
	 nasm  -f elf skeleton.s -o skeleton.o

.PHONY: clean
clean:
	rm -f *.o virus
