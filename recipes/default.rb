#
# Cookbook Name:: aircover
# Recipe:: default
#
# Copyright (c) 2016 Jacob McCann, All Rights Reserved.

include_recipe 'chef-vault::default'

docker_service 'default' do
  version node['aircover']['docker']['version'] unless node['aircover']['docker']['version'].nil?
  host ['unix:///var/run/docker.sock']
  storage_driver 'aufs'
  action [:create, :start]
end

docker_image 'aircover' do
  repo 'aircover/aircover'
  tag node['aircover']['version']
end

docker_container 'aircover' do
  repo 'aircover/aircover'
  tag node['aircover']['version']
  port '80:8000'
  env aircover_env
  volumes ['/var/lib/aircover:/var/lib/aircover']
  restart_policy 'always'
  sensitive true
end
