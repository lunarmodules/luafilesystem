# $Id: Makefile,v 1.19 2005/05/30 17:54:49 uid20006 Exp $

T= lfs

include ./config

V= 1.1
DIST_DIR= luafilesystem-$V
TAR_FILE= $(DIST_DIR).tar.gz
ZIP_FILE= $(DIST_DIR).zip
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
	rm -f $L src/$(LIBNAME) $(OBJS)

dist: dist_dir
	tar -czf $(TAR_FILE) $(DIST_DIR)
	zip -rq $(ZIP_FILE) $(DIST_DIR)/*
	rm -rf $(DIST_DIR)

dist_dir:
	mkdir -p $(DIST_DIR)
	cp config $(SRCS) $T.h $T.def Makefile *html luafilesystem.png $(DIST_DIR)
