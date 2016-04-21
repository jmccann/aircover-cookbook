#
# Cookbook Name:: aircover
# Spec:: default
#
# Copyright (c) 2016 Jacob McCann, All Rights Reserved.

require 'spec_helper'

describe 'aircover::github_auth' do
  context 'When all attributes are default, on ubuntu-15.04' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '15.04') do |_node, server|
        inject_databags server
      end
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'updates aircover container with github auth config' do
      expect(chef_run).to run_docker_container('aircover').with(env: ['DATABASE_DRIVER=sqlite3', 'DATABASE_CONFIG=/var/lib/drone/drone.sqlite',
                                                                      'GITHUB_URL=https://github.company.com',
                                                                      'GITHUB_CLIENT=github_client',
                                                                      'GITHUB_SECRET=github_secret'])
    end
  end
end
