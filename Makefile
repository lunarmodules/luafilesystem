# $Id: Makefile,v 1.35 2008/12/12 13:26:37 carregal Exp $

T= lfs

CONFIG= ./config

include $(CONFIG)

SRCS= src/$T.c
OBJS= src/$T.o

lib: src/lfs.so

src/lfs.so: $(OBJS)
	MACOS_DEPLOYMENT_TARGET="10.3"; export MACOSX_DEPLOYMENT_TARGET; $(CC) $(CFLAGS) $(LIB_OPTION) -o src/lfs.so $(OBJS)

install:
	mkdir -p $(LUA_LIBDIR)
	cp src/lfs.so $(LUA_LIBDIR)

clean:
	rm -f src/lfs.so $(OBJS)
