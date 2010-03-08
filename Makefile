SHELL=/bin/sh

TARGET=$(wildcard test-*.scm)

test:
	@rm -f test.log
	@for X in $(TARGET) ; do gosh $$X >> test.log ; done

clean:
	rm -rf *~ test.log
