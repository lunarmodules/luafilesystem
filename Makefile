# $Id: Makefile,v 1.34 2008/05/07 19:06:37 carregal Exp $

T= lfs

CONFIG= ./config

include $(CONFIG)

SRCS= src/$T.c
OBJS= src/$T.o

lib: src/lfs.so

src/lfs.so: $(OBJS)
	export MACOSX_DEPLOYMENT_TARGET="10.3"; $(CC) $(CFLAGS) $(LIB_OPTION) -o src/lfs.so $(OBJS)

install:
	mkdir -p $(LUA_LIBDIR)
	cp src/lfs.so $(LUA_LIBDIR)

clean:
	rm -f src/lfs.so $(OBJS)
