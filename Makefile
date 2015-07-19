KDIR ?= /lib/modules/$(shell uname -r)/build
obj-m := asus-wmi.o asus-nb-wmi.o

SRCS=asus-wmi.c asus-nb-wmi.c asus-wmi.h asus-nb-wmi.c

all: $(SRCS)
	make -C $(KDIR) M=$$PWD modules

install:
	make -C $(KDIR) M=$$PWD modules_install

clean:
	make -C $(KDIR) M=$$PWD clean
