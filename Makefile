# raw makefile
# - ease repeatitive operations

all:

PWD		:= $(shell pwd)
JEKYLL_DST	:= /home/jerome/webwork/www.jotnode.org.gh-pages
NODE_NEOIP_DIR	:= /home/jerome/webwork/node-neoip

server:
	lighttpd -f lighttpd.conf  -D
		
upload: jekyll_build
	(cd $(JEKYLL_DST) && git add . && git commit -a -m 'new build' && git push)

jekyll_build:
	(cd $(JEKYLL_DST) && git reset --hard origin/gh-pages)
	touch $(JEKYLL_DST)/.nojekyll
	/home/jerome/work/jekyll/bin/jekyll . $(JEKYLL_DST)
	
jekyll_monitor:
	(while inotifywait -r -e modify,attrib,create . ; do make jekyll_build; done)
