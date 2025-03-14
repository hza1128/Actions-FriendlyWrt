#!/bin/bash

#sed -i -e '579i\CONFIG_TARGET_ROOTFS_EXT4FS=y' configs/rockchip/01-nanopi
sed -i -e '460i\CONFIG_PACKAGE_luci-app-passwall=y' configs/rockchip/01-nanopi
sed -i -e '460a\CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus=n' configs/rockchip/01-nanopi
sed -i -e '460a\CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Plugin=n' configs/rockchip/01-nanopi
sed -i '/CONFIG_PACKAGE_vsftpd=y/d' configs/rockchip/01-nanopi
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=768/g' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_MAKE_TOOLCHAIN=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-aria2=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-ddns=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-minidlna=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-nft-qos=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-ntpc=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-adblock=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-watchcat=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-hd-idle=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-nlbwmon=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-smartdns=y/d' configs/rockchip/01-nanopi
sed -i -e '/CONFIG_PACKAGE_luci-app-cpufreq=y/d' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_IB=y/# CONFIG_IB is not set/g' configs/rockchip/01-nanopi
sed -i -e 's/CONFIG_SDK=y/# CONFIG_SDK is not set/g' configs/rockchip/01-nanopi
sed -i 's/=y/=n/g' configs/rockchip/02-luci_lang
sed -i 's/CONFIG_LUCI_LANG_en=n/CONFIG_LUCI_LANG_en=y/' configs/rockchip/02-luci_lang
sed -i 's/CONFIG_LUCI_LANG_zh_Hans=n/CONFIG_LUCI_LANG_zh_Hans=y/' configs/rockchip/02-luci_lang

use luci-app-cpufreq in friendlywrt
config_file_cpufreq=`find friendlywrt/package/ -follow -type f -path '*/luci-app-cpufreq/root/etc/config/cpufreq'`
truncate -s-1 $config_file_cpufreq
echo -e "\toption governor0 'schedutil'" >> $config_file_cpufreq
echo -e "\toption minfreq0 '816000'" >> $config_file_cpufreq
echo -e "\toption maxfreq0 '1512000'\n" >> $config_file_cpufreq

sed -i "s/option limit_enable '1'/option limit_enable '0'/" `find friendlywrt/package/ -follow -type f -path '*/nft-qos/files/nft-qos.config'`

## set ip address
chmod a+x ../patches_my/ip_addr_r6-t6.sh
cp ../patches_my/ip_addr_r6-t6.sh `find friendlywrt/target/ -follow -type d -path '*rockchip*/root'`
echo '[ -f /root/ip_addr_r6-t6.sh ] && /root/ip_addr_r6-t6.sh' >> `find friendlywrt/target/ -follow -type f -path '*rockchip*/uci-defaults/vendor.defaults'`
