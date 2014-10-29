include $(TOP)/.config

all:

clean:

install:
	rm -rf $(INSTALLDIR)/*
	mkdir -p $(INSTALLDIR)/www
	#mkdir -p $(INSTALLDIR)/js
	#mkdir -p $(INSTALLDIR)/css

	#cp *.jsp *.svg *.jsx *.ico robots.txt $(INSTALLDIR)/www
	cp *.jsp *.jsx *.ico robots.txt $(INSTALLDIR)/www
	cp -a images $(INSTALLDIR)/www/images
	cp -a js $(INSTALLDIR)/www/js
	cp -a css $(INSTALLDIR)/www/css
	cp -a lang_pack $(INSTALLDIR)/www/lang_pack
	cp -a products $(INSTALLDIR)/www/products

# squish some of the files by trimming whitespace...

	#for F in *.{js,jsx}; do \
	#	sed '/^\/\*\s*$$/,/\*\//! { s/^\s\+//; s/\s\+$$//; /^\/\/ --\+\s*/d; /^$$/d }' < $$F > $(INSTALLDIR)/$$F; \
	#done

	#for F in *.css; do \
	#	sed '/^\/\*\s*$$/,/\*\//! { s/\s\+/ /g; s/^\s\+//; s/\s\+$$//; /^$$/d }' < $$F > $(INSTALLDIR)/$$F; \
	#done

# remove "debug.js" references, convert color.css -> nv().css, remove comments
# in between REMOVE-BEGIN and REMOVE-END, and compress whitespace

	#for F in *.{jsp,svg}; do \
	#	sed	-e "/REMOVE-BEGIN/,/REMOVE-END/d" \
	#		-e "s,<script[^>]\+debug\.js[^>]\+></script>,," \
	#		-e "s,color\.css,<% nv('web_css'); %>\.css," \
	#		-e "s,<!-- / / / -->,," \
	#		-e "/^$$/d" \
	#		-e "/^<!--$$/,/^-->$$/! { s,^\s\+, , }" $$F > $(INSTALLDIR)/$$F; \
	#done
	
# make sure old and debugging crap is gone
	#@rm -f $(INSTALLDIR)/debug.js
	#@rm -f $(INSTALLDIR)/*-x.*
	#@rm -f $(INSTALLDIR)/*-old.*
	#@rm -f $(INSTALLDIR)/color.css
	#chmod 0644 $(INSTALLDIR)/*
