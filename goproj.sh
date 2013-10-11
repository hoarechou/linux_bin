#!/bin/bash

CSCOPE_FILE=cscope.file1
if [ -n "$1" ]; then
	echo "Source code directory: " $1
	echo "Create file map : " $CSCOPE_FILE
	echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
	find $1 -type f \( -name "*.[ch]"  -o -name "*.[ch]pp" \)  -printf "%f\t%p\t1\n"|sort -f >>filenametags
	
    # you can modify here for your source file suffix
    # Android
	find $1 -name "*.aidl" \
            -o -name "*.cc" \
            -o -name "*.h" \
            -o -name "*.c" \
            -o -name "*.cpp" \
            -o -name "*.java" \
            -o -name "*.mk" \
            > $CSCOPE_FILE
	ctags -R --exclude=.svn --exclude=.git
	cscope -bkq -i $CSCOPE_FILE
	#cscope -Rbk -i $CSCOPE_FILE
else
	echo "Please key-in path of project" 
fi

