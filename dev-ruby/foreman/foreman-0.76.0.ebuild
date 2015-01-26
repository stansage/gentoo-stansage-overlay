# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_RECIPE_TEST="rspec"
RUBY_FAKEGEM_RECIPE_DOC="none"
RUBY_FAKEGEM_EXTRADOC="Changelog.md README.md"

inherit ruby-fakegem

DESCRIPTION="Manage Procfile-based applications"
HOMEPAGE="https://github.com/ddollar/foreman"
SRC_URI="https://github.com/ddollar/foreman/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

ruby_add_rdepend ">=dev-ruby/dotenv-0.7
	>=dev-ruby/thor-0.13.6"
ruby_add_bdepend "test? (
		dev-ruby/fakefs
		dev-ruby/timecop
		dev-ruby/simplecov
		dev-ruby/rr
	)"

RESTRICT="test"
# tests try to chown and access /var/log, etc.
# fixes below are not enough, unfortunately

all_ruby_prepare() {
	sed -i -e '/bundler/d' Rakefile || die "sed failed"

	sed -i \
		-e "s|/tmp|${T}|g" \
		spec/foreman/*.rb \
		spec/foreman/export/*.rb \
		spec/resources/export/*/*.{pill,concurrency,default,conf} \
		spec/resources/export/*/*/run || die "sed failed"
}
