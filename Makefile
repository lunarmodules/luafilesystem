# $Id: Makefile,v 1.6 2004/10/15 10:07:53 tomas Exp $

T= lfs

include ./config

V= 1.0a
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

install: $(LIBNAME)
	mkdir -p $(LIB_DIR)
	cp $(LIBNAME) $(LIB_DIR)
	ln -f -s $(LIB_DIR)/$(LIBNAME) $(LIB_DIR)/$T$(LIB_EXT)

clean:
	rm -f $L $(LIBNAME) $(OBJS)

dist: dist_dir
	tar -czf $(TAR_FILE) $(DIST_DIR)
	zip -rq $(ZIP_FILE) $(DIST_DIR)/*
	rm -rf $(DIST_DIR)

dist_dir:
	mkdir -p $(DIST_DIR)
	cp config $(SRCS) $T.h $T.def Makefile *html $(DIST_DIR)
