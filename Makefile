APP = libgpio
 
LIBSOURCES=*.c
OUTS = *.o
NAME := gpio
MAJOR = 1
MINOR = 1
VERSION = $(MAJOR).$(MINOR)
 
all: lib$(NAME).so
lib$(NAME).so.$(VERSION): $(OUTS)
	$(CC) $(LDFLAGS) $(OUTS) -shared -Wl,-soname,lib$(NAME).so.$(MAJOR) -o lib$(NAME).so
	$(CC) $(LDFLAGS) $(OUTS) -shared -Wl,-soname,lib$(NAME).so.$(MAJOR) -o lib$(NAME).so.$(VERSION)
 
lib$(NAME).so: lib$(NAME).so.$(VERSION)
	rm -f lib$(NAME).so.$(MAJOR) lib$(NAME).so
	ln -s lib$(NAME).so.$(VERSION) lib$(NAME).so.$(MAJOR)
	ln -s lib$(NAME).so.$(MAJOR) lib$(NAME).so
 
%.o: %.c
	$(CC) $(CFLAGS) -c -fPIC $(LIBSOURCES) -isystem ./.
 
clean:
	rm -rf *.o *.so *.so.*