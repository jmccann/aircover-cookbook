default['aircover']['version'] = 'latest'
default['aircover']['vault'] = 'vault_aircover'
default['aircover']['docker']['version'] = nil # Use latest

default['aircover']['config']['database_driver'] = 'sqlite3'
default['aircover']['config']['database_config'] = '/var/lib/drone/drone.sqlite'
