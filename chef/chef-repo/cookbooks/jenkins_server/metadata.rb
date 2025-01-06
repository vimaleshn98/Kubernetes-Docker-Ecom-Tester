name 'jenkins_server'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures jenkins_server'
version '1.1.1'
chef_version '>= 16.0'

depends 'jenkins', '~> 9.5.23'  # Ensure the version is exactly 6.0.0
  # Ensure that the version matches what you uploaded
# gem 'ed25519', '>= 1.2', '< 2.0'
# gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'

# gem 'ed25519', '>= 1.2', '< 2.0'
# gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0'
# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/jenkins_server/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/jenkins_server'
