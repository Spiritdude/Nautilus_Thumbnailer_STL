
all::
	@echo "make install deinstall"

install::
	sudo cp stl.thumbnailer /usr/share/thumbnailers/
	sudo cp stl2png.pl /usr/local/bin/
	sudo cp stl.xml /usr/share/mime/packages/
	sudo update-mime-database /usr/share/mime/

deinstall::
	rm -f /usr/share/thumbnailers/stl.thumbnailer /usr/local/bin/stl2png.pl /usr/share/mime/packages/stl.xml
	sudo update-mime-database /usr/local/share/mime/

