#!/bin/sh
# This program is needed primarily because the Norme
# (the code standard @ School 42) restricts the comment format to the one that
# isn't recognised by Doxygen. Hence, a pre-processing with perl is needed.
# This script also performs post-doxygen clean-up.

command -v doxygen >/dev/null
if [ $? -ne 0 ]; then
	echo "Please install Doxygen!"
else
	sed -i '1s#^#///\\file\n#' libftprintfgnl.h
	perl -i -pe 's#^\/\*$#/\*\*#' libftprintfgnl.h
	doxygen docs/.doxygen/Doxyfile
	sed -i '1d' libftprintfgnl.h
	perl -i -pe 's#^\/\*\*$#/\*#' libftprintfgnl.h
fi
