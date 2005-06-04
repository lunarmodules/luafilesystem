# $Id: Makefile,v 1.20 2005/06/04 18:22:29 tomas Exp $

T= lfs

include ./config

V= 1.1
LIBNAME= lib$T.$V.so

COMPAT_O= $(COMPAT_DIR)/compat-5.1.o
SRCS= src/$T.c
OBJS= src/$T.o $(COMPAT_O)


lib: src/$(LIBNAME)

src/$(LIBNAME): $(OBJS)
	$(CC) $(CFLAGS) $(LIBS) $(LIB_OPTION) -o src/$(LIBNAME) $(OBJS)

$(COMPAT_O): $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install: src/$(LIBNAME)
	mkdir -p $(LUA_LIBDIR)
	cp src/$(LIBNAME) $(LUA_LIBDIR)
	ln -f -s $(LUA_LIBDIR)/$(LIBNAME) $(LUA_LIBDIR)/$T.so

clean:
	rm -f src/$(LIBNAME) $(OBJS)
