################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2017 Team LibreELEC
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

PKG_NAME="dvb_tv-aml"
PKG_VERSION="53f633d"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kszaq/dvb_tv-aml"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="driver"
PKG_SHORTDESC="dvb_tv-aml: Internal DVB tuner driver for Amlogic devices developed by afl1"
PKG_LONGDESC="dvb_tv-aml: Internal DVB tuner driver for Amlogic devices developed by afl1"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}

post_install() {
  enable_service amlogic-dvb.service
}
