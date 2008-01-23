# $Id: Makefile,v 1.31 2008/01/23 02:48:47 mascarenhas Exp $

T= lfs
V= 1.3.0
CONFIG= ./config

include $(CONFIG)

SRCS= src/$T.c
OBJS= src/$T.o

lib: src/lfs.so

src/lfs.so: $(OBJS)
	export MACOSX_DEPLOYMENT_TARGET="10.3"; $(CC) $(CFLAGS) $(LIB_OPTION) -o src/lfs.so $(OBJS)

install: src/lfs.so
	mkdir -p $(LUA_LIBDIR)
	cp src/lfs.so $(LUA_LIBDIR)

clean:
	rm -f src/lfs.so $(OBJS)
