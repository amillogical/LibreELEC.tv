################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="game.libretro.vba-next"
PKG_VERSION="b075650"
PKG_SHA256="2ac50f8c2143e44ef0e55a440e3dd05d72cc438713b6ce37ddc7850a1055cd90"
PKG_REV="103"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-game/game.libretro.vba-next"
PKG_URL="https://github.com/kodi-game/game.libretro.vba-next/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libretro-vba-next"
PKG_SECTION=""
PKG_SHORTDESC="game.libretro.vba-next: VBA-Next emulator for Kodi"
PKG_LONGDESC="game.libretro.vba-next: VBA-Next emulator for Kodi"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.gameclient"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        ..
}
