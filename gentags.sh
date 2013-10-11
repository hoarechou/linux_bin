#!/bin/sh
# generate tag file for lookupfile plugin

echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
TOP=$(pwd)/android
path[1]="$TOP"
#paths[1]="$TOP/kernel/drivers/media/video/msm"
#paths[2]="$TOP/vendor/qcom/proprietary/mm-camera"
#paths[3]="$TOP/hardware/qcom/camera"
#paths[4]="$TOP/kernel/arch/arm/mach-msm"

for ((i=0; i<${#paths[@]}+1; i++)) do
	echo "find ${paths[$i]} -type f \( -name "*.[ch]"  -o -name "*.[ch]pp" \)  -printf "%f\t%p\t1\n"|sort -f >>filenametags"
	find ${paths[$i]} -type f \( -name "*.[ch]"  -o -name "*.[ch]pp" \)  -printf "%f\t%p\t1\n"|sort -f >>filenametags
	echo "find ${paths[$i]} -type f \( -name "*.[ch]"  -o -name "*.[ch]pp" \)  -printf "$PWD/%P\n"|sort -f >>cscope.files"
	find ${paths[$i]} -type f \( -name "*.[ch]"  -o -name "*.[ch]pp" \)  -printf "%$PWD/%P\n"|sort -f >>cscope.files
done
echo "creating cscop db"
cscope -bkq -i cscope.files
ctags -L cscope.files
