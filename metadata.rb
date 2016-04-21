name             'aircover'
maintainer       'Jacob McCann'
maintainer_email 'jacob.mccann2@target.com'
license          'all_rights'
description      'Installs/Configures aircover'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url       'https://github.com/jmccann/aircover-cookbook'
issues_url       'https://github.com/jmccann/aircover-cookbook/issues'
version          '0.1.0'

depends 'docker', '2.6.8'
depends 'chef-vault'
