CC = gcc
LD = ld
CFLAGS = -m32 -static -MD -std=gnu89 -ggdb \
 		 -fno-builtin -fno-stack-protector -fno-omit-frame-pointer \
 		 -Wall -Werror -O2 -I./include
ASFLAGS = -m32 -MD
LDFLAGS = -melf_i386
QEMU = qemu-system-i386

CFILES = $(shell find src/ -name "*.c")
SFILES = $(shell find src/ -name "*.S")
OBJS = $(CFILES:.c=.o) $(SFILES:.S=.o)

game.img: game
	@cd boot; make
	cat boot/bootblock game > game.img

game: $(OBJS)
	$(LD) $(LDFLAGS) -e game_init -Ttext 0x00100000 -o game $(OBJS)

-include $(patsubst %.o, %.d, $(OBJS))

.PHONY: play clean debug

play: game.img
	$(QEMU) -serial stdio game.img
debug: game.img
	$(QEMU) -serial stdio -s -S game.img

clean:
	@cd boot; make clean
	rm -f game game.img $(OBJS) $(OBJS:.o=.d)
