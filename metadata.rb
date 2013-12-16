name             'role-builder'
maintainer       'Balanced'
maintainer_email 'dev@balancedpayments.com'
license          'MIT'
description      'Installs/Configures role-balanced-api'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends          'role-base'
depends          'postfix'
depends          'balanced-postgres'
depends          'balanced-app'
