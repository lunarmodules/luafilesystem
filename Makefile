# $Id: Makefile,v 1.30 2007/06/07 01:28:08 tomas Exp $

T= lfs
V= 1.3.0
CONFIG= ./config

include $(CONFIG)

SRCS= src/$T.c
OBJS= src/$T.o

lib: src/$(LIBNAME)

src/$(LIBNAME): $(OBJS)
	export MACOSX_DEPLOYMENT_TARGET="10.3"; $(CC) $(CFLAGS) $(LIB_OPTION) -o src/$(LIBNAME) $(OBJS)

install: src/$(LIBNAME)
	mkdir -p $(LUA_LIBDIR)
	cp src/$(LIBNAME) $(LUA_LIBDIR)
	cd $(LUA_LIBDIR); ln -f -s $(LIBNAME) $T.so

clean:
	rm -f src/$(LIBNAME) $(OBJS)
