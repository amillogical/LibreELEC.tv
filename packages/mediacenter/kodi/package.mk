################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="kodi"
PKG_VERSION="d103c09"
PKG_SHA256="2497e3be7ac979208c3745d50e66258b4e81deb1c56be17e56c06fd2999a8aa9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/xbmc/xbmc/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="xbmc-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain JsonSchemaBuilder:host TexturePacker:host Python zlib systemd pciutils lzo pcre swig:host libass curl fontconfig fribidi tinyxml libjpeg-turbo freetype libcdio taglib libxml2 libxslt rapidjson sqlite ffmpeg crossguid giflib libdvdnav libhdhomerun libfmt"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="kodi: Kodi Mediacenter"
PKG_LONGDESC="Kodi Media Center (which was formerly named Xbox Media Center or XBMC) is a free and open source cross-platform media player and home entertainment system software with a 10-foot user interface designed for the living-room TV. Its graphical user interface allows the user to easily manage video, photos, podcasts, and music from a computer, optical disk, local network, and the internet using a remote control."
PKG_AUTORECONF="no"

get_graphicdrivers

PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET dbus"

if [ "$TARGET_ARCH" = "x86_64" ] || [ "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET nss"
fi

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libX11 libXext libdrm libXrandr"
  KODI_XORG="-DCORE_PLATFORM_NAME=x11"
fi

if [ ! "$OPENGL" = "no" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glu"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
fi

if [ "$ALSA_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET alsa-lib"
  KODI_ALSA="-DENABLE_ALSA=ON"
else
  KODI_ALSA="-DENABLE_ALSA=OFF"
fi

if [ "$PULSEAUDIO_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pulseaudio"
  KODI_PULSEAUDIO="-DENABLE_PULSEAUDIO=ON"
else
  KODI_PULSEAUDIO="-DENABLE_PULSEAUDIO=OFF"
fi

if [ "$ESPEAK_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET espeak"
fi

if [ "$CEC_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libcec"
  KODI_CEC="-DENABLE_CEC=ON"
else
  KODI_CEC="-DENABLE_CEC=OFF"
fi

if [ "$KODI_OPTICAL_SUPPORT" = yes ]; then
  KODI_OPTICAL="-DENABLE_OPTICAL=ON"
else
  KODI_OPTICAL="-DENABLE_OPTICAL=OFF"
fi

if [ "$KODI_NONFREE_SUPPORT" = yes ]; then
  KODI_NONFREE="-DENABLE_NONFREE=ON"
else
  KODI_NONFREE="-DENABLE_NONFREE=OFF"
fi

if [ "$KODI_DVDCSS_SUPPORT" = yes ]; then
  KODI_DVDCSS="-DENABLE_DVDCSS=ON \
               -DLIBDVDCSS_URL=$ROOT/$SOURCES/libdvdcss/libdvdcss-$(get_pkg_version libdvdcss).tar.gz"
else
  KODI_DVDCSS="-DENABLE_DVDCSS=OFF"
fi

if [ "$KODI_BLURAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libbluray"
  KODI_BLURAY="-DENABLE_BLURAY=ON"
else
  KODI_BLURAY="-DENABLE_BLURAY=OFF"
fi

if [ "$AVAHI_DAEMON" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET avahi nss-mdns"
  KODI_AVAHI="-DENABLE_AVAHI=ON"
else
  KODI_AVAHI="-DENABLE_AVAHI=OFF"
fi

if [ "$KODI_MYSQL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mysql"
  KODI_MYSQL="-DENABLE_MYSQLCLIENT=ON"
else
  KODI_MYSQL="-DENABLE_MYSQLCLIENT=OFF"
fi

if [ "$KODI_AIRPLAY_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libplist"
  KODI_AIRPLAY="-DENABLE_PLIST=ON"
else
  KODI_AIRPLAY="-DENABLE_PLIST=OFF"
fi

if [ "$KODI_AIRTUNES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libshairplay"
  KODI_AIRTUNES="-DENABLE_AIRTUNES=ON"
else
  KODI_AIRTUNES="-DENABLE_AIRTUNES=OFF"
fi

if [ "$KODI_NFS_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libnfs"
  KODI_NFS="-DENABLE_NFS=ON"
else
  KODI_NFS="-DENABLE_NFS=OFF"
fi

if [ "$KODI_SAMBA_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET samba"
fi

if [ "$KODI_WEBSERVER_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libmicrohttpd"
fi

if [ "$KODI_UPNP_SUPPORT" = yes ]; then
  KODI_UPNP="-DENABLE_UPNP=ON"
else
  KODI_UPNP="-DENABLE_UPNP=OFF"
fi

if [ "$KODI_SSHLIB_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libssh"
  KODI_SSH="-DENABLE_SSH=ON"
else
  KODI_SSH="-DENABLE_SSH=OFF"
fi

if echo "$TARGET_FPU" | grep -q '^neon' || [[ "$TARGET_ARCH" = "aarch64" ]]; then
  KODI_NEON="-DENABLE_NEON=ON"
else
  KODI_NEON="-DENABLE_NEON=OFF"
fi

if [ "$VDPAU_SUPPORT" = "yes" -a "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
  KODI_VDPAU="-DENABLE_VDPAU=ON"
else
  KODI_VDPAU="-DENABLE_VDPAU=OFF"
fi

if [ "$VAAPI_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET intel-vaapi-driver"
  KODI_VAAPI="-DENABLE_VAAPI=ON"
else
  KODI_VAAPI="-DENABLE_VAAPI=OFF"
fi

if [ "$TARGET_ARCH" = "x86_64" ]; then
  KODI_ARCH="-DWITH_CPU=$TARGET_ARCH"
else
  KODI_ARCH="-DWITH_ARCH=$TARGET_ARCH"
fi

if [ "$DEVICE" = "Slice" -o "$DEVICE" = "Slice3" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET led_tools"
fi

if [ ! "$KODIPLAYER_DRIVER" = default ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $KODIPLAYER_DRIVER"
  if [ "$KODIPLAYER_DRIVER" = bcm2835-driver ]; then
    KODI_PLAYER="-DCORE_PLATFORM_NAME=rbpi"
  elif [ "$KODIPLAYER_DRIVER" = mesa ]; then
    KODI_PLAYER="-DCORE_PLATFORM_NAME=gbm"
    CFLAGS="$CFLAGS -DMESA_EGL_NO_X11_HEADERS"
    CXXFLAGS="$CXXFLAGS -DMESA_EGL_NO_X11_HEADERS"
  elif [ "$KODIPLAYER_DRIVER" = libfslvpuwrap ]; then
    KODI_PLAYER="-DCORE_PLATFORM_NAME=imx"
    CFLAGS="$CFLAGS -DHAS_IMXVPU -DLINUX -DEGL_API_FB"
    CXXFLAGS="$CXXFLAGS -DHAS_IMXVPU -DLINUX -DEGL_API_FB"
  elif [ "$KODIPLAYER_DRIVER" = libamcodec ]; then
    KODI_PLAYER="-DCORE_PLATFORM_NAME=aml"
  fi
fi

KODI_LIBDVD="$KODI_DVDCSS \
             -DLIBDVDNAV_URL=$ROOT/$SOURCES/libdvdnav/libdvdnav-$(get_pkg_version libdvdnav).tar.gz \
             -DLIBDVDREAD_URL=$ROOT/$SOURCES/libdvdread/libdvdread-$(get_pkg_version libdvdread).tar.gz"

PKG_CMAKE_OPTS_TARGET="-DNATIVEPREFIX=$TOOLCHAIN \
                       -DWITH_TEXTUREPACKER=$TOOLCHAIN/bin/TexturePacker \
                       -DDEPENDS_PATH=$PKG_BUILD/depends \
                       -DPYTHON_EXECUTABLE=$TOOLCHAIN/bin/python2.7 \
                       -DPYTHON_INCLUDE_DIRS=$SYSROOT_PREFIX/usr/include/python2.7 \
                       -DGIT_VERSION=$PKG_VERSION \
                       -DWITH_FFMPEG=$(get_build_dir ffmpeg) \
                       -DENABLE_INTERNAL_FFMPEG=OFF \
                       -DFFMPEG_INCLUDE_DIRS=$SYSROOT_PREFIX/usr \
                       -DENABLE_INTERNAL_CROSSGUID=OFF \
                       -DENABLE_SDL=OFF \
                       -DENABLE_OPENSSL=ON \
                       -DENABLE_UDEV=ON \
                       -DENABLE_DBUS=ON \
                       -DENABLE_XSLT=ON \
                       -DENABLE_CCACHE=ON \
                       -DENABLE_LIRC=ON \
                       -DENABLE_EVENTCLIENTS=ON \
                       -DENABLE_LDGOLD=ON \
                       -DENABLE_DEBUGFISSION=OFF \
                       $KODI_ARCH \
                       $KODI_NEON \
                       $KODI_VDPAU \
                       $KODI_VAAPI \
                       $KODI_CEC \
                       $KODI_XORG \
                       $KODI_SAMBA \
                       $KODI_NFS \
                       $KODI_LIBDVD \
                       $KODI_AVAHI \
                       $KODI_UPNP \
                       $KODI_MYSQL \
                       $KODI_SSH \
                       $KODI_AIRPLAY \
                       $KODI_AIRTUNES \
                       $KODI_NONFREE \
                       $KODI_OPTICAL \
                       $KODI_BLURAY \
                       $KODI_PLAYER"

pre_configure_target() {
# kodi should never be built with lto
  strip_lto

  export LIBS="$LIBS -lncurses"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/kodi
  rm -rf $INSTALL/usr/bin/kodi-standalone
  rm -rf $INSTALL/usr/bin/xbmc
  rm -rf $INSTALL/usr/bin/xbmc-standalone
  rm -rf $INSTALL/usr/share/kodi/cmake
  rm -rf $INSTALL/usr/share/applications
  rm -rf $INSTALL/usr/share/icons
  rm -rf $INSTALL/usr/share/pixmaps
  rm -rf $INSTALL/usr/share/kodi/addons/skin.estouchy
  rm -rf $INSTALL/usr/share/kodi/addons/skin.estuary
  rm -rf $INSTALL/usr/share/kodi/addons/service.xbmc.versioncheck
  rm -rf $INSTALL/usr/share/kodi/addons/visualization.vortex
  rm -rf $INSTALL/usr/share/xsessions

  mkdir -p $INSTALL/usr/lib/kodi
    cp $PKG_DIR/scripts/kodi-config $INSTALL/usr/lib/kodi
    cp $PKG_DIR/scripts/kodi.sh $INSTALL/usr/lib/kodi

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/systemd-addon-wrapper $INSTALL/usr/lib/libreelec

  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/cputemp $INSTALL/usr/bin
      ln -sf cputemp $INSTALL/usr/bin/gputemp
    cp $PKG_DIR/scripts/setwakeup.sh $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/share/kodi/addons
    cp -R $PKG_DIR/config/os.openelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/os.openelec.tv/addon.xml
    cp -R $PKG_DIR/config/os.libreelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@OS_VERSION@|$OS_VERSION|g" -i $INSTALL/usr/share/kodi/addons/os.libreelec.tv/addon.xml
    cp -R $PKG_DIR/config/repository.libreelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@ADDON_URL@|$ADDON_URL|g" -i $INSTALL/usr/share/kodi/addons/repository.libreelec.tv/addon.xml
    cp -R $PKG_DIR/config/repository.kodi.game $INSTALL/usr/share/kodi/addons
    cp -R $PKG_DIR/config/repository.retroplayer.libreelec.tv $INSTALL/usr/share/kodi/addons
    $SED "s|@ADDON_URL@|http://lrusak.libreelec.tv/addons/$ADDON_PATH|g" $INSTALL/usr/share/kodi/addons/repository.retroplayer.libreelec.tv/addon.xml

  mkdir -p $INSTALL/usr/share/kodi/config
  mkdir -p $INSTALL/usr/share/kodi/system/settings

  $PKG_DIR/scripts/xml_merge.py $PKG_DIR/config/guisettings.xml \
                                $PROJECT_DIR/$PROJECT/kodi/guisettings.xml \
                                $PROJECT_DIR/$PROJECT/devices/$DEVICE/kodi/guisettings.xml \
                                > $INSTALL/usr/share/kodi/config/guisettings.xml

  $PKG_DIR/scripts/xml_merge.py $PKG_DIR/config/sources.xml \
                                $PROJECT_DIR/$PROJECT/kodi/sources.xml \
                                $PROJECT_DIR/$PROJECT/devices/$DEVICE/kodi/sources.xml \
                                > $INSTALL/usr/share/kodi/config/sources.xml

  $PKG_DIR/scripts/xml_merge.py $PKG_DIR/config/advancedsettings.xml \
                                $PROJECT_DIR/$PROJECT/kodi/advancedsettings.xml \
                                $PROJECT_DIR/$PROJECT/devices/$DEVICE/kodi/advancedsettings.xml \
                                > $INSTALL/usr/share/kodi/system/advancedsettings.xml

  $PKG_DIR/scripts/xml_merge.py $PKG_DIR/config/appliance.xml \
                                $PROJECT_DIR/$PROJECT/kodi/appliance.xml \
                                $PROJECT_DIR/$PROJECT/devices/$DEVICE/kodi/appliance.xml \
                                > $INSTALL/usr/share/kodi/system/settings/appliance.xml

  # update addon manifest
  ADDON_MANIFEST=$INSTALL/usr/share/kodi/system/addon-manifest.xml
  xmlstarlet ed -L -d "/addons/addon[text()='service.xbmc.versioncheck']" $ADDON_MANIFEST
  xmlstarlet ed -L -d "/addons/addon[text()='skin.estouchy']" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.kodi.game" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "os.libreelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "os.openelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.libreelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "repository.retroplayer.libreelec.tv" $ADDON_MANIFEST
  xmlstarlet ed -L --subnode "/addons" -t elem -n "addon" -v "service.libreelec.settings" $ADDON_MANIFEST

  # more binaddons cross compile badness meh
  sed -e "s:INCLUDE_DIR /usr/include/kodi:INCLUDE_DIR $SYSROOT_PREFIX/usr/include/kodi:g" \
      -e "s:CMAKE_MODULE_PATH /usr/lib/kodi /usr/share/kodi/cmake:CMAKE_MODULE_PATH $SYSROOT_PREFIX/usr/share/kodi/cmake:g" \
      -i $SYSROOT_PREFIX/usr/share/kodi/cmake/KodiConfig.cmake

  if [ "$KODI_EXTRA_FONTS" = yes ]; then
    mkdir -p $INSTALL/usr/share/kodi/media/Fonts
      cp $PKG_DIR/fonts/*.ttf $INSTALL/usr/share/kodi/media/Fonts
  fi

  debug_strip $INSTALL/usr/lib/kodi/kodi.bin

  case $PROJECT in
    S805|S905|S912)
      cp $PKG_DIR/scripts/aml-hdmimonitor.sh $INSTALL/usr/lib/kodi/aml-hdmimonitor.sh
      ;;
  esac
}

post_install() {
  enable_service kodi.target
  enable_service kodi-autostart.service
  enable_service kodi-cleanlogs.service
  enable_service kodi-halt.service
  enable_service kodi-poweroff.service
  enable_service kodi-reboot.service
  enable_service kodi-waitonnetwork.service
  enable_service kodi.service
  enable_service kodi-lirc-suspend.service

  case $PROJECT in
    S805|S905|S912)
      enable_service kodi-aml-hdmimonitor.service
      ;;
  esac
}
