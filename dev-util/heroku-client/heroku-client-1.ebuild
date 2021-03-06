# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Client tools for heroku"
HOMEPAGE="http://heroku.com"
SRC_URI="http://assets.heroku.com.s3.amazonaws.com/${PN}/${PN}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/ruby"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
}

src_install() {
	dodir "/opt/heroku"
	cp -r "${S}"/* "${D}"/opt/heroku
	dodir "/usr/bin"
	dosym /opt/heroku/bin/heroku /usr/bin/heroku
}

pkg_postinst() {
	einfo "To start using heroku, please create first an account at"
	einfo "${HOMEPAGE}, then run"
	einfo " \$ heroku login"
	einfo "this will ask for your login data and generate a public ssh key"
	einfo "for you if needed. To deploy your app do:"
	einfo " \$ cd ~/myapp"
	einfo " \$ heroku create"
}
