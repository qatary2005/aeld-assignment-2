# Makefile for Assignment 2 writer C application
# Supports native compilation (gcc) and cross-compilation (aarch64-none-linux-gnu-gcc)

CC ?= gcc
ifneq ($(CROSS_COMPILE),)
    CC := $(CROSS_COMPILE)gcc
endif

CFLAGS ?= -Wall -Werror

TARGET = writer
OBJS = writer.o

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

writer.o: writer.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) $(OBJS)
