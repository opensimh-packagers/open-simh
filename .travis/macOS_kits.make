# Make dmg package from directory and/or tar archive

# Inputs (Typical values)

#ARCNAME  := 2023-02-27-17-19-03-05-00-c3ac62c8f389087eed5e86e4d989186c129df486-macOS-x86-Release
#DIRNAME  := macOS-x86-Release
#BRANCH   := V4
#REFTYPE  := branch
#REFNAME  := packager
#TARBALL  := 2023-02-27-17-19-03-05-00-c3ac62c8f389087eed5e86e4d989186c129df486-macOS-x86-Release.tar.xz
#TARDIR   := 2023-02-27-17-19-03-05-00-c3ac62c8f389087eed5e86e4d989186c129df486-macOS-x86-Release.tar-contents.txt

SHELL := $(strip $(shell ( [ -x "/bin/bash" ] && echo "/bin/bash" ) || ( [ -x /usr/bin/bash ] && echo "/usr/bin/bash" ) || echo "Help-Noshell!!" ))


.PHONY : all

all :
	echo "$(SHELL) $(ARCNAME) $(DIRNAME) $(BRANCH) $(REFTYPE) $(REFNAME) $(TARBALL) $(TARDIR)"
	echo "I conjured $(ARCNAME).dmg from $(DIRNAME)"
