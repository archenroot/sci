# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit python-single-r1 wxwidgets

DESCRIPTION="View and analyze genome sequences"
HOMEPAGE="http://www.ncbi.nlm.nih.gov/projects/gbench/"
SRC_URI="ftp://ftp.ncbi.nlm.nih.gov/toolbox/gbench/ver-"${PV}"/gbench-src-"${PV}".tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
#KEYWORDS="~amd64 ~x86"
IUSE="xml ssl sybase-ct zlib lzo pcre gnutls freetds mysql berkdb python opengl glut icu expat sqlite hdf5 jpeg png tiff gif xpm sybase threads fltk cgi"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	app-arch/bzip2
	app-text/sablotron
	dev-cpp/muParser
	dev-libs/boost:=
	dev-libs/expat
	dev-libs/icu
	dev-libs/libxslt
	lzo? ( dev-libs/lzo )
	dev-libs/xalan-c
	dev-libs/xerces-c
	dev-util/cppunit
	media-libs/freetype
	media-libs/giflib
	media-libs/tiff:0=
	gnutls? ( net-libs/gnutls )
	hdf5? ( sci-libs/hdf5 )
	sys-fs/fuse
	berkdb? ( >=sys-libs/db-4.3:* )
	glut? ( virtual/glu )
	opengl? ( virtual/opengl
		media-libs/ftgl
		media-libs/glew:= )
	x11-libs/fltk
	>=x11-libs/gtk+-2:*
	x11-libs/wxGTK:*
	mysql? ( virtual/mysql )
	pcre? ( dev-libs/libpcre )
	sqlite? ( dev-db/sqlite:3= )
	ssl? ( dev-libs/openssl:0= )
	sybase-ct? ( dev-db/freetds )
	xml? ( dev-libs/libxml2:2= )
	xpm? (
		x11-libs/libXpm
		virtual/jpeg:0=
		media-libs/libpng:0=
		sys-libs/zlib
	)
"
DEPEND="${RDEPEND}"

# recycle ebuild logic from ncbi-tools++

S="${WORKDIR}"/gbench-src-"${PV}"

src_configure(){
	# configure: error: --mandir=/usr/share/man:  unknown option;  use --help to show usage
	# configure: error: --infodir=/usr/share/info:  unknown option;  use --help to show usage
	# configure: error: --datadir=/usr/share:  unknown option;  use --help to show usage
	# configure: error: --sysconfdir=/etc:  unknown option;  use --help to show usage
	# configure: error: --localstatedir=/var/lib:  unknown option;  use --help to show usage
	./configure --prefix="${DESTDIR}"/"${EPREFIX}/usr" --libdir="${EPREFIX}/usr/$(get_libdir)" CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}" || die
}
