PKG_NAME="qt-everywhere"
PKG_VERSION="5.6.2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt.io/official_releases/qt/5.6/$PKG_VERSION/single/$PKG_NAME-opensource-src-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="pcre zlib"
PKG_SOURCE_DIR="$PKG_NAME-opensource-src-$PKG_VERSION"
PKG_LONGDESC="A cross-platform application and UI framework"

PKG_CONFIGURE_OPTS_TARGET="-prefix /usr
                           -sysroot $SYSROOT_PREFIX
                           -hostprefix $TOOLCHAIN
                           -device linux-libreelec-g++
                           -opensource -confirm-license
                           -release
                           -static
                           -make libs
                           -force-pkg-config
                           -no-accessibility
                           -no-sql-sqlite
                           -no-sql-mysql
                           -no-qml-debug
                           -system-zlib
                           -no-mtdev
                           -no-gif
                           -no-libjpeg
                           -no-harfbuzz
                           -no-libproxy
                           -system-pcre
                           -no-glib
                           -silent
                           -no-cups
                           -no-iconv
                           -no-evdev
                           -no-tslib
                           -no-icu
                           -no-strip
                           -no-fontconfig
                           -no-dbus
                           -no-opengl
                           -no-libudev
                           -no-libinput
                           -no-eglfs
                           -skip qt3d
                           -skip qtactiveqt
                           -skip qtandroidextras
                           -skip qtcanvas3d
                           -skip qtconnectivity
                           -skip qtdeclarative
                           -skip qtdoc
                           -skip qtgraphicaleffects
                           -skip qtimageformats
                           -skip qtlocation
                           -skip qtmacextras
                           -skip qtmultimedia
                           -skip qtquickcontrols
                           -skip qtquickcontrols2
                           -skip qtscript
                           -skip qtsensors
                           -skip qtserialbus
                           -skip qtsvg
                           -skip qttranslations
                           -skip qtwayland
                           -skip qtwebchannel
                           -skip qtwebengine
                           -skip qtwebsockets
                           -skip qtwebview
                           -skip qtwinextras
                           -skip qtx11extras
                           -skip qtxmlpatterns"

configure_target() {
  QMAKE_CONF_DIR="qtbase/mkspecs/devices/linux-libreelec-g++"
  QMAKE_CONF="${QMAKE_CONF_DIR}/qmake.conf"

  cd ..
  mkdir -p $QMAKE_CONF_DIR
  echo "MAKEFILE_GENERATOR       = UNIX" > $QMAKE_CONF
  echo "CONFIG                  += incremental" >> $QMAKE_CONF
  echo "QMAKE_INCREMENTAL_STYLE  = sublib" >> $QMAKE_CONF
  echo "include(../../common/linux.conf)" >> $QMAKE_CONF
  echo "include(../../common/gcc-base-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/g++-unix.conf)" >> $QMAKE_CONF
  echo "load(device_config)" >> $QMAKE_CONF
  echo "QMAKE_CC                = $CC" >> $QMAKE_CONF
  echo "QMAKE_CXX               = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK              = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK_SHLIB        = $CXX" >> $QMAKE_CONF
  echo "QMAKE_AR                = $AR cqs" >> $QMAKE_CONF
  echo "QMAKE_OBJCOPY           = $OBJCOPY" >> $QMAKE_CONF
  echo "QMAKE_NM                = $NM -P" >> $QMAKE_CONF
  echo "QMAKE_STRIP             = $STRIP" >> $QMAKE_CONF
  echo "QMAKE_CFLAGS = $CFLAGS" >> $QMAKE_CONF
  echo "QMAKE_CXXFLAGS = $CXXFLAGS" >> $QMAKE_CONF
  echo "QMAKE_LFLAGS = $LDFLAGS" >> $QMAKE_CONF
  echo "load(qt_config)" >> $QMAKE_CONF
  echo '#include "../../linux-g++/qplatformdefs.h"' >> $QMAKE_CONF_DIR/qplatformdefs.h

  unset CC CXX LD RANLIB AR AS CPPFLAGS CFLAGS LDFLAGS CXXFLAGS
  ./configure $PKG_CONFIGURE_OPTS_TARGET
}
