rm -rf package/emortal/luci-app-athena-led
git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led

# PassWall2
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git package/openwrt-passwall
git clone --depth=1 https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/luci-app-passwall2
# 避免 feeds 与 passwall-packages 同名包冲突
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/net/chinadns-ng
rm -rf feeds/packages/net/tcping
rm -rf feeds/packages/net/geoview
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/simple-obfs
rm -rf feeds/packages/net/v2ray-plugin