# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

MY_PN="VisionLibraries"
MY_P="${MY_PN}-${PV/_rc3/}"

DESCRIPTION="MGLTools Plugin -- VisionLibraries"
HOMEPAGE="http://mgltools.scripps.edu"
SRC_URI="http://mgltools.scripps.edu/downloads/tars/releases/REL${PV}/mgltools_source_${PV}.tar.gz"

LICENSE="MGLTOOLS MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/swig"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	tar xzpf "${DISTDIR}"/${A} mgltools_source_${PV/_/}/MGLPACKS/${MY_P}.tar.gz || die
	tar xzpf mgltools_source_${PV/_/}/MGLPACKS/${MY_P}.tar.gz || die
}

python_prepare_all() {
	ecvs_clean
	find "${S}" -name LICENSE -type f -delete || die

	sed  \
		-e 's:^.*CVS:#&1:g' \
		-e 's:^.*LICENSE:#&1:g' \
		-i "${S}"/MANIFEST.in || die
	distutils-r1_python_prepare_all
}
