#!/bin/sh
# generate tag file for lookupfile plugin

echo -e "!_TAG_FILE_SORTED\t2\t/2=foldcase/" > filenametags
TOP=pwd
paths=($TOP/kernel/driver/media/video/msm $TOP/vendor/qcom/proprietary/mm-camera $TOP/hardware/qcom/camera \
$TOP/kernel/arch/arm/mach-msm)

for name in ${paths[@]}; do
	find `pwd` -type f \( -name "*.[ch]"  -o -name "*.[ch]pp" \) -printf "%f\t%p\t1\n"|sort -f >>filenametags
done
