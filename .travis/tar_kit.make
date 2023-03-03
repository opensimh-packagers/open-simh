# Make tar archives for binary distributions

# Debug: set as make command arguments:
#ARCNAME  := 2023-02-27-17-19-03-05-00-c3ac62c8f389087eed5e86e4d989186c129df486-Linux-x86-Release
#DIRNAME  := Linux-x86-Release
#OS       := Linux

# ROOT is where the tar directory structure is created
# It will be created and removed
ROOT := tmp

# Compression extension (implies type)
CMP  := .bz2

SHELL := $(strip $(shell ( [ -x "/bin/bash" ] && echo "/bin/bash" ) || ( [ -x /usr/bin/bash ] && echo "/usr/bin/bash" ) || echo "Help-Noshell!!" ))

ifeq ($(OS),Linux)
dest := $(ROOT)/opt/OpenSIMH
TAR  := tar
else
dest := $(ROOT)/OpenSIMH
TAR  := gtar
endif

bindir := $(dest)/bin
docdir := $(dest)/doc

CHOWN := chown
CP    := cp
FIND  := find
MKDIR := mkdir
MV    := mv
RM    := rm
SUDO  := sudo

.PHONY : all

all :
	echo "'$(SHELL)' $(BRANCH) $(REFTYPE) $(REFNAME)"
	$(MKDIR) -p $(bindir) $(docdir)
	$(FIND) $(DIRNAME) -type f ! -name '*.txt' -exec $(CP) -p {} $(bindir) \;
	$(FIND) $(DIRNAME) -type f   -name '*.txt' -exec $(CP) -p {} $(docdir) \;
	$(SUDO) $(CHOWN) -R 0:0 $(ROOT)
	cd tmp && $(TAR) -caf ../$(ARCNAME).tar$(CMP) $(patsubst $(ROOT)/%,%,$(docdir)) $(patsubst $(ROOT)/%,%,$(bindir))
	$(MV) $(ARCNAME).tar-contents.txt $(ARCNAME).tar-contents.txt.bak
	while read -r line; do  [[ "$$line" =~ ^$$ ]] && break; [[ "$$line" =~ ^In\ the\ archive ]] || echo "$$line" >>$(ARCNAME).tar-contents.txt ; done <$(ARCNAME).tar-contents.txt.bak || true
	$(TAR) -tvaf $(ARCNAME).tar$(CMP) >>$(ARCNAME).tar-contents.txt
	$(SUDO) $(RM) -rf $(ROOT) $(ARCNAME).tar-contents.txt.bak
