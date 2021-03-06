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

ext_DIR ?= $(abs_top_builddir)/ext


MDSPLUS_DIR   = $(ext_DIR)/mdsplus

MDS_SRCDIR    = $(MDSPLUS_DIR)
MDS_BUILDDIR  = $(MDSPLUS_DIR)
MDS_LIBDIR    = $(MDS_BUILDDIR)/lib$(MDS_LIBSUFFIX)
MDS_BINDIR    = $(MDS_BUILDDIR)/bin$(MDS_LIBSUFFIX)

MDSCPPFLAGS  = -I${MDS_BUILDDIR}/include -I${MDS_SRCDIR}/include
MDSLDFLAGS   = -L${MDS_LIBDIR} \
			   -lMdsObjectsCppShr -lMdsShr -lTreeShr -lTdiShr -lMdsIpShr \
			   -lpthread -lm

MDS_CLASSPATH = $(addprefix $(MDS_BUILDDIR)/,\
				javascope/jScope.jar \
				javascope/WaveDisaply.jar \
				mdsobjects/java/mdsobjects.jar \
				javatraverser/DeviceBeans.jar \
				javatraverser/jTraverser.jar \
				javadevices/jDevices.jar \
				javadispatcher/jDispatcher.jar )


export MDS_PATH := $(MDS_SRCDIR)/tdi
export MDSPLUS_DIR := $(MDSPLUS_DIR)
export CLASSPATH := $(if ${CLASSPATH},${MDS_CLASSPATH}:${CLASSPATH},${MDS_CLASSPATH})
export LD_LIBRARY_PATH := $(if ${LD_LIBRARY_PATH},${MDS_LIBDIR}:${LD_LIBRARY_PATH},${MDS_LIBDIR})
export PYTHONPATH := $(if ${PYTHONPATH},$(MDS_SRCDIR)/python:${PYTHONPATH},$(MDS_SRCDIR)/python)

ext-mdsplus: ##@ext external mdsplus compilation
ext-mdsplus:
if MDSPLUS_DOWNLOAD
	@ $(MAKE) -C $(ext_DIR) $@ && \
	  cd $(MDSPLUS_DIR)/python/MDSplus && \
	  $(PYTHON) setup.py install --user 
endif

mdsplus-%: ##@ext external mdsplus compilation
mdsplus-%:
if MDSPLUS_DOWNLOAD
	@ $(MAKE) -C $(MDS_BUILDDIR) $*
endif

