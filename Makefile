# $Id: Makefile,v 1.2 2004/07/29 14:26:33 tomas Exp $

T= lfs

include ./config

V= 1.0a
LIBNAME= lib$T.$V$(LIB_EXT)
L= $T.lua
TL= t_$T.lua

SRCS= $T.c
OBJS= $T.o


lib: $(LIBNAME)

$(LIBNAME): $(OBJS) $(TL)
	$(CC) $(CFLAGS) $(LIB_OPTION) -o $(LIBNAME) $(OBJS) $(LIBS)
	sed -e "s|LIB_NAME|$(LIB_DIR)/$(LIBNAME)|" $(TL) > $L

$(LUA_DIR)/$L: $L
	mkdir -p $(LUA_DIR)
	cp $L $(LUA_DIR)

install: $(LUA_DIR)/$L $(LIBNAME)
	mkdir -p $(LIB_DIR)
	cp $(LIBNAME) $(LIB_DIR)

clean:
	rm -f $L $(LIBNAME) $(OBJS)

dist:
	mkdir -p $(DIST_DIR)
	cp config $(SRCS) $T.h $(TL) Makefile $(DIST_DIR)
