# Makefile

CC  = gcc
ELF = TEST_PRG
SRC = main.c
OBJ = $(SRC:%.c=%.o)
# LIBS= -lpthread -lm -liio
OPS = -Wall


# MAKE RULE
all: $(ELF)

$(ELF): $(OBJ)
	$(CC) $^ $(LIBS) $(OPS) -o $@

.SUFFIXES: .o .c
.c.o:
	$(CC) -c $< $(OPS)


# CLER
.PHONY: clean
clean:
	$(RM) $(OBJ) $(ELF)

