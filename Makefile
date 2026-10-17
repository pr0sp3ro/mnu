# mnu - dynamic menu
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c mnu.c stest.c util.c
OBJ = $(SRC:.c=.o)

all: mnu stest

.c.o:
	$(CC) -c $(CFLAGS) $<

$(OBJ): arg.h config.mk drw.h

mnu.o: config.h
mnu.o drw.o util.o: util.h

mnu: mnu.o drw.o util.o
	$(CC) -o $@ mnu.o drw.o util.o $(LDFLAGS)

stest: stest.o
	$(CC) -o $@ stest.o $(LDFLAGS)

clean:
	rm -f mnu stest $(OBJ) mnu-$(VERSION).tar.gz

dist: clean
	mkdir -p mnu-$(VERSION)
	cp LICENSE Makefile README.md arg.h config.h config.mk mnu.1\
		drw.h util.h mnu_path mnu_run stest.1 $(SRC)\
		mnu-$(VERSION)
	tar -cf mnu-$(VERSION).tar mnu-$(VERSION)
	gzip mnu-$(VERSION).tar
	rm -rf mnu-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f mnu mnu_path mnu_run stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mnu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mnu_path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/mnu_run
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < mnu.1 > $(DESTDIR)$(MANPREFIX)/man1/mnu.1
	sed "s/VERSION/$(VERSION)/g" < stest.1 > $(DESTDIR)$(MANPREFIX)/man1/stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/mnu.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/mnu\
		$(DESTDIR)$(PREFIX)/bin/mnu_path\
		$(DESTDIR)$(PREFIX)/bin/mnu_run\
		$(DESTDIR)$(PREFIX)/bin/stest\
		$(DESTDIR)$(MANPREFIX)/man1/mnu.1\
		$(DESTDIR)$(MANPREFIX)/man1/stest.1

.PHONY: all clean dist install uninstall
