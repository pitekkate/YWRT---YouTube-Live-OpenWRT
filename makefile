include $(TOPDIR)/rules.mk

PKG_NAME:=youtube-live
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/luci/luci.mk

define Package/youtube-live
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=YouTube Live Streaming
  DEPENDS:=+ffmpeg +rtmpdump +screen +v4l-utils +alsa-utils
endef

define Package/youtube-live/description
  A tool to stream live video to YouTube from OpenWRT devices.
endef

define Package/youtube-live-luci
  SECTION:=luci
  CATEGORY:=LuCI
  SUBSECTION:=3. Applications
  TITLE:=LuCI Interface for YouTube Live Streaming
  DEPENDS:=+youtube-live +luci-base +luci-compat
  PKGARCH:=all
endef

define Package/youtube-live-luci/description
  LuCI interface for YouTube Live Streaming on OpenWRT
endef

define Build/Prepare
    mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/youtube-live/install
    $(INSTALL_DIR) $(1)/etc/config
    $(INSTALL_DIR) $(1)/etc/init.d
    $(INSTALL_DIR) $(1)/usr/bin
    
    $(INSTALL_CONF) ./files/etc/config/youtube-live $(1)/etc/config/
    $(INSTALL_BIN) ./files/etc/init.d/youtube-live $(1)/etc/init.d/
    $(INSTALL_BIN) ./src/youtube-live $(1)/usr/bin/
    $(INSTALL_BIN) ./files/usr/bin/youtube-live-helper $(1)/usr/bin/
endef

define Package/youtube-live-luci/install
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/youtube-live
    $(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/youtube-live
    
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/controller/youtube-live.lua $(1)/usr/lib/lua/luci/controller/
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/model/cbi/youtube-live/settings.lua $(1)/usr/lib/lua/luci/model/cbi/youtube-live/
    $(INSTALL_DATA) ./files/usr/lib/lua/luci/view/youtube-live/status_control.htm $(1)/usr/lib/lua/luci/view/youtube-live/
endef

$(eval $(call BuildPackage,youtube-live))
$(eval $(call BuildPackage,youtube-live-luci))
