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

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="7f7df25"
PKG_SHA256="1a542dddf065d1bf69076b505bcd73a32e5167a29326e9b22d74cec87f304fae"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_SECTION="tools"
PKG_SHORTDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
    cp -PRv LICENCE* $INSTALL/usr/share/bootloader
    cp -PRv bootcode.bin $INSTALL/usr/share/bootloader
    cp -PRv fixup_x.dat $INSTALL/usr/share/bootloader/fixup.dat
    cp -PRv start_x.elf $INSTALL/usr/share/bootloader/start.elf

    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/dt-blob.bin ]; then
      cp -PRv $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/dt-blob.bin $INSTALL/usr/share/bootloader
    fi

    cp -PRv $PKG_DIR/scripts/update.sh $INSTALL/usr/share/bootloader

    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/distroconfig.txt ]; then
      cp -PRv $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/distroconfig.txt $INSTALL/usr/share/bootloader
    elif [ -f $PROJECT_DIR/$PROJECT/config/distroconfig.txt ]; then
      cp -PRv $PROJECT_DIR/$PROJECT/config/distroconfig.txt $INSTALL/usr/share/bootloader
    elif [ -f $DISTRO_DIR/$DISTRO/config/distroconfig.txt ]; then
      cp -PRv $DISTRO_DIR/$DISTRO/config/distroconfig.txt $INSTALL/usr/share/bootloader
    else
      cp -PRv $PKG_DIR/files/3rdparty/bootloader/distroconfig.txt $INSTALL/usr/share/bootloader
    fi

    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/config.txt ]; then
      cp -PRv $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/config.txt $INSTALL/usr/share/bootloader
    elif [ -f $PROJECT_DIR/$PROJECT/config/config.txt ]; then
      cp -PRv $PROJECT_DIR/$PROJECT/config/config.txt $INSTALL/usr/share/bootloader
    elif [ -f $DISTRO_DIR/$DISTRO/config/config.txt ]; then
      cp -PRv $DISTRO_DIR/$DISTRO/config/config.txt $INSTALL/usr/share/bootloader
    else
      cp -PRv $PKG_DIR/files/3rdparty/bootloader/config.txt $INSTALL/usr/share/bootloader
    fi
}
