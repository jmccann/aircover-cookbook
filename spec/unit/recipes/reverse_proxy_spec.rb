#
# Cookbook Name:: aircover
# Spec:: default
#
# Copyright (c) 2016 Jacob McCann, All Rights Reserved.

require 'spec_helper'

describe 'aircover::reverse_proxy' do
  context 'When all attributes are default, on ubuntu-15.04' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '15.04') do |_node, server|
        inject_databags server
      end
      runner.converge(described_recipe)
    end

    before do
      stub_command('which nginx').and_return(true)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'deploys our certificate' do
      expect(chef_run).to create_certificate_manage('aircover_certs').with(data_bag_type: 'vault',
                                                                           data_bag: 'vault_aircover',
                                                                           owner: 'root',
                                                                           group: 'root')
    end

    it 'installs nginx' do
      expect(chef_run).to include_recipe 'nginx::default'
    end

    it 'uses our nginx conf template' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/default').with(cookbook: 'aircover', source: 'nginx-default-site.erb')
    end

    it 'configures nginx with our cert' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/default').with_content('ssl_certificate /etc/ssl/certs/fauxhai.local.pem;')
      expect(chef_run).to render_file('/etc/nginx/sites-available/default').with_content('ssl_certificate_key /etc/ssl/private/fauxhai.local.key;')
    end

    it 'bind aircover container to port 8000' do
      expect(chef_run).to run_docker_container('aircover').with(port: '8000:8000')
    end
  end
end
