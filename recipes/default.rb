#
# Cookbook Name:: docker-registry
# Recipe:: default
# Author:: Raul E Rangel <Raul.Rangel@disney.com>
#
# Copyright 2008-2012, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

virtual_env_path = ::File.join(node['docker-registry']['install_dir'], "shared", "env", node['docker-registry']['revision'])

python_virtualenv virtual_env_path do
  path virtual_env_path
  owner node['docker-registry']['owner']
  group node['docker-registry']['group']
  action :create
end

application "docker-registry" do
  owner node['docker-registry']['owner']
  group node['docker-registry']['group']
  path node['docker-registry']['install_dir']
  repository node['docker-registry']['repository']
  revision node['docker-registry']['revision']
  packages ["libevent-dev", "git"]
  
  action :force_deploy

  before_restart do
    template "#{new_resource.path}/current/config.yml" do
      source "config.yml.erb"
      mode 0440
      owner node['docker-registry']['owner']
      group node['docker-registry']['group']
    end
  end

  gunicorn do
    only_if { node['roles'].include?('docker-registry_application_server') }

    requirements "requirements.txt"
    max_requests node['docker-registry']['max_requests']
    timeout node['docker-registry']['timeout']
    port node['docker-registry']['internal_port']
    workers node['docker-registry']['workers']
    worker_class "gevent"
    app_module "wsgi:application"

    virtualenv virtual_env_path

    environment :SETTINGS_FLAVOR => node['docker-registry']['flavor']
  end

  nginx_load_balancer do
    only_if { node['roles'].include?('docker-registry_load_balancer') }
    application_port node['docker-registry']['internal_port']
    server_name (node['docker-registry']['server_name'] || node['fqdn'] || node['hostname'])
  end
end
