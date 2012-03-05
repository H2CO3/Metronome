TARGET = Metronome
OBJECTS = $(patsubst %.m,%.o,$(wildcard *.m))
SYSROOT = /Developer/Platforms/iPhoneOS.platform/SDKs/iPhoneOS4.2.sdk
DEST = /Applications/$(TARGET).app

CC = gcc
LD = $(CC)
RM = rm
CP = cp
CFLAGS = -isysroot $(SYSROOT) -std=gnu99 -Wall -Os -c
LDFLAGS = -isysroot $(SYSROOT) -w -lobjc -lm -framework Foundation -framework UIKit -framework AVFoundation
RMFLAGS = -rf
CPFLAGS = -r

all: $(TARGET)

clean:
	$(RM) $(RMFLAGS) *~ *.o $(TARGET)

install: all
	$(CP) $(CPFLAGS) $(TARGET) $(DEST)

$(TARGET): $(OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

%.o: %.m
	$(CC) $(CFLAGS) $^

%.o: %.c
	$(CC) $(CFLAGS) $^

%.m: %.h

%.c: %.h

.PHONY: all clean install
