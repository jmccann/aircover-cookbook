#
# Cookbook Name:: aircover
# Spec:: default
#
# Copyright (c) 2016 Jacob McCann, All Rights Reserved.

require 'spec_helper'

describe 'aircover::default' do
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

    it 'installs docker host' do
      expect(chef_run).to create_docker_service 'default'
      expect(chef_run).to start_docker_service 'default'
    end

    it 'pulls aircover docker container' do
      expect(chef_run).to pull_docker_image('aircover').with(repo: 'aircover/aircover', tag: 'latest')
    end

    it 'starts aircover container' do
      expect(chef_run).to run_docker_container('aircover').with(repo: 'aircover/aircover', tag: 'latest', port: '80:8000',
                                                                env: ['DATABASE_DRIVER=sqlite3', 'DATABASE_CONFIG=/var/lib/drone/drone.sqlite',
                                                                      'REMOTE_CONFIG=https://github.com?client_id=000&client_secret=000&open=true&private_mode=true'],
                                                                volumes_binds: ['/var/lib/aircover:/var/lib/aircover'],
                                                                restart_policy: 'always',
                                                                sensitive: true)
    end
  end
end
