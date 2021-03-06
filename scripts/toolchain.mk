## ////////////////////////////////////////////////////////////////////////// //
##
## This file is part of the autoconf-bootstrap project.
## Copyright 2018 Andrea Rigoni Garola <andrea.rigoni@igi.cnr.it>.
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.
##
## ////////////////////////////////////////////////////////////////////////// //

# /////////////////////////////////////////////////////////////////////////////
# //  TOOLCHAIN  //////////////////////////////////////////////////////////////
# /////////////////////////////////////////////////////////////////////////////
## TODO: remove this and put it to configure
## TODO: identify file type
#
TOOLCHAIN_DIR ?= $(top_builddir)/toolchain
if TOOLCHAIN_RETRIEVE_TAR
$(top_builddir)/toolchain:
	@ \
	  mkdir -p ${DL} $@; \
	  echo "getting toolchain from tar: ${TOOLCHAIN_TAR}"; \
	  _tar=${DL}/$$(echo $(TOOLCHAIN_TAR) | sed -e 's|.*/||'); \
	  test -f $$_tar || curl -SL $(TOOLCHAIN_TAR) > $$_tar; \
	  _wcl=$$(tar -tJf $$_tar | sed -e 's|/.*||' | uniq | wc -l); \
	  if test $$_wcl = 1; then \
	  tar -xJf $$_tar -C $@ --strip 1; \
	  else \
	  tar -xJf $$_tar -C $@; \
	  fi
else
$(top_builddir)/toolchain:
endif


ARCH                     = arm
# TOOLCHAIN_DIR           ?= ${abs_top_builddir}/toolchain
TOOLCHAIN_PATH           = ${TOOLCHAIN_DIR}/bin
CROSS_COMPILE            = arm-linux-gnueabihf-

export PATH := ${TOOLCHAIN_PATH}:${PATH}


$(CROSS_TARGETS): export CC:=$(CROSS_COMPILE)$(CC)
$(CROSS_TARGETS): export CXX:=$(CROSS_COMPILE)$(CXX)
$(CROSS_TARGETS): export AR:=$(CROSS_COMPILE)$(AR)
$(CROSS_TARGETS): export AS:=$(CROSS_COMPILE)$(AS)


