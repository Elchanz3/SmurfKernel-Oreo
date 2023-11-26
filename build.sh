#!/bin/bash

mkdir out

export ANDROID_MAJOR_VERSION=8
export ANDROID_PLATFORM_VERSION=80000

make O=out ARCH=arm64 exynos8895-greatlte_defconfig

DATE_START=$(date +"%s")

make O=out ARCH=arm64 -j12

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))

IMAGE="out/arch/arm64/boot/Image"
if [[ -f "$IMAGE" ]]; then
	rm AnyKernel3/zImage > /dev/null 2>&1
	rm AnyKernel3/dtb > /dev/null 2>&1
	rm AnyKernel3/*.zip > /dev/null 2>&1
	mv $IMAGE AnyKernel3/zImage
	cd AnyKernel3
	zip -r9 SovereignKernel-N950F-$(date +"%Y%m%d%H%M")-beta_aosp.zip .
fi
