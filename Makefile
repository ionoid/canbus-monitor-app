.PHONY: all image canbus-mon reduce pack

all: canbus-mon-armv7.tar.gz

image:
	DOCKER_BUILDKIT=1 DOCKER_CLI_EXPERIMENTAL=enabled docker buildx build --platform linux/arm/v7 -t ionoid/canbus-monitor .

canbus-mon: image
	docker save ionoid/canbus-monitor | undocker --no-whiteouts -d -i -o canbus-mon ionoid/canbus-monitor

reduce: canbus-mon
	rm -fr ./canbus-mon/root/.npm
	rm -fr ./canbus-mon/tmp/*

pack: canbus-mon-armv7.tar.gz

canbus-mon-armv7.tar.gz: reduce
	tar --numeric-owner --create --auto-compress --xattrs --xattrs-include=* --file $@ --directory canbus-mon --transform='s,^./,,' .
