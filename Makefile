# $Id: Makefile,v 1.11 2005/01/18 10:48:02 tomas Exp $

T= lfs

include ./config

V= 1.1b
DIST_DIR= luafilesystem-$V
TAR_FILE= $(DIST_DIR).tar.gz
ZIP_FILE= $(DIST_DIR).zip
LIBNAME= lib$T.$V$(LIB_EXT)

SRCS= $T.c
OBJS= $T.o compat-5.1.o


lib: $(LIBNAME)

$(LIBNAME): $(OBJS)
	$(CC) $(CFLAGS) $(LIB_OPTION) -o $(LIBNAME) $(OBJS) $(LIBS)

compat-5.1.o: $(COMPAT_DIR)/compat-5.1.c
	$(CC) -c $(CFLAGS) -o $@ $(COMPAT_DIR)/compat-5.1.c

install: $(LIBNAME)
	mkdir -p $(LUA_LIBDIR)
	cp $(LIBNAME) $(LUA_LIBDIR)
	ln -f -s $(LUA_LIBDIR)/$(LIBNAME) $(LUA_LIBDIR)/$T$(LIB_EXT)

clean:
	rm -f $L $(LIBNAME) $(OBJS)

dist: dist_dir
	tar -czf $(TAR_FILE) $(DIST_DIR)
	zip -rq $(ZIP_FILE) $(DIST_DIR)/*
	rm -rf $(DIST_DIR)

dist_dir:
	mkdir -p $(DIST_DIR)
	cp config $(SRCS) $T.h $T.def Makefile *html luafilesystem.png $(DIST_DIR)
