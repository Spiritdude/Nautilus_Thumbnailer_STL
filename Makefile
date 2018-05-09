
all::
	@echo "make install deinstall"

install::
	sudo cp stl.thumbnailer /usr/share/thumbnailers/
	sudo cp thumb_stl.py /usr/local/bin/
	sudo cp stl.xml /usr/share/mime/packages/
	sudo update-mime-database /usr/share/mime/

deinstall::
	rm -f /usr/share/thumbnailers/stl.thumbnailer /usr/local/bin/thumb_stl.py /usr/share/mime/packages/stl.xml
	sudo update-mime-database /usr/local/share/mime/

