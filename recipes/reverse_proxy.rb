include_recipe 'aircover::default'

# Install certs
certificate_manage 'aircover_certs' do
  data_bag_type 'vault'
  data_bag node['aircover']['vault']
  owner 'root'
  group 'root'
end

# Install/Configure nginx
include_recipe 'nginx::default'

# Override their template with our own
resources("template[#{node['nginx']['dir']}/sites-available/default]").cookbook 'aircover'
resources("template[#{node['nginx']['dir']}/sites-available/default]").source 'nginx-default-site.erb'

# Change host port to bind 8000 so webserver can start on port 80
resources('docker_container[aircover]').port '8000:8000'
