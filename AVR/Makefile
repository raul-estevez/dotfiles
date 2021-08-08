
##### MCU relared config #####
MCU =
F_CPU =
BAUD = 9600UL

##### PROGRAMER #####
PROGRAMMER_TYPE = usbtiny
PROGRAMMER_ARGS = # USBTiny works with no further arguments
LIBDIR = /usr/avr/include

##### PROGRAMS USED, DONT CHANGE IF THEY ARE IN PATH #####
CC = avr-gcc
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
AVRSIZE = avr-size
AVRDUDE = avrdude

##### COMPILING #####

TARGET = $(lastword $(subst /, ,$(CURDIR)))

# Use all .c files in current directory. If you have any other (sub-)directories with code,you can add them in to SOURCES below in the wildcard statement separeted with spaces.	
SOURCES = $(wildcard *.c) 					
OBJECTS=$(SOURCES:.c=.o)
HEADERS=$(SOURCES:.c=.h)

# Compilation options
CPPFLAGS = -DF_CPU=$(F_CPU) -DBAUD=$(BAUD) -I. -I$(LIBDIR)
CFLAGS = -Os -g -std=gnu99 -Wall
## Use short (8-bit) data types 
CFLAGS += -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums 

## Splits up object files per function
CFLAGS += -ffunction-sections -fdata-sections 
LDFLAGS = -Wl,-Map,$(TARGET).map 
## Optional, but often ends up with smaller code
LDFLAGS += -Wl,--gc-sections
## Add MCU to CFLAGS
CFLAGS += -mmcu=$(MCU)
## I dont know why this but I have to do it
TARGET_ARCH = -mmcu=$(MCU)


## Explicit pattern rules:
##  To make .o files from .c files
%.o: %.c $(HEADERS) Makefile
	 $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -o $@ $<;

$(TARGET).elf: $(OBJECTS)
	$(CC) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@

%.hex: %.elf
	 $(OBJCOPY) -j .text -j .data -O ihex $< $@

%.eeprom: %.elf
	$(OBJCOPY) -j .eeprom --change-section-lma .eeprom=0 -O ihex $< $@

%.lst: %.elf
	$(OBJDUMP) -S $< > $@


## These targets don't have files named after them
.PHONY: all disassemble disasm eeprom size clean squeaky_clean flash fuses

all: $(TARGET).hex

debug:
	@echo
	@echo "Source files:"   $(SOURCES)
	@echo "MCU, F_CPU, BAUD:"  $(MCU), $(F_CPU), $(BAUD)
	@echo

# Optionally create listing file from .elf
# This creates approximate assembly-language equivalent of your code.
# Useful for debugging time-sensitive bits,
# or making sure the compiler does what you want.
disassemble: $(TARGET).lst

disasm: disassemble

# Optionally show how big the resulting program is
size:  $(TARGET).elf
	$(AVRSIZE) -t $(TARGET).elf

clean:
	rm -f $(TARGET).elf $(TARGET).hex $(TARGET).obj \
	$(TARGET).o $(TARGET).d $(TARGET).eep $(TARGET).lst \
	$(TARGET).lss $(TARGET).sym $(TARGET).map $(TARGET)~ \
	$(TARGET).eeprom

squeaky_clean:
	rm -f *.elf *.hex *.obj *.o *.d *.eep *.lst *.lss *.sym *.map *~ *.eeprom


##### FLASHIND CODE TO AVR USING avrdude #####

flash: $(TARGET).hex
	$(AVRDUDE) -c $(PROGRAMMER_TYPE) -p $(MCU) $(PROGRAMMER_ARGS) -U flash:w:$<

## An alias
program: flash

flash_eeprom: $(TARGET).eeprom
	$(AVRDUDE) -c $(PROGRAMMER_TYPE) -p $(MCU) $(PROGRAMMER_ARGS) -U eeprom:w:$<

avrdude_terminal:
	$(AVRDUDE) -c $(PROGRAMMER_TYPE) -p $(MCU) $(PROGRAMMER_ARGS) -nt






##########------------------------------------------------------##########
##########         CAUTION CAUTION CAUTION ZONE: FUSES          ##########
##########------------------------------------------------------##########

# VALUES YOU WANT FOR FUSES
LFUSE = 
HFUSE =
EFUSE =

# Generic fuse string 
FUSE_STRING = -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -U efuse:w:$(EFUSE):m 

fuses: 
	$(AVRDUDE) -c $(PROGRAMMER_TYPE) -p $(MCU) \
	           $(PROGRAMMER_ARGS) $(FUSE_STRING)
show_fuses:
		$(AVRDUDE) -c $(PROGRAMMER_TYPE) -p $(MCU) $(PROGRAMMER_ARGS) -nv
