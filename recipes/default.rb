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

#include_recpie "application_python"
#include_recpie "application_nginx"

application "docker-registry" do
  path node['docker-registry']['install_dir']
  repository node['docker-registry']['repository']
  revision node['docker-registry']['revision']
  packages ["libevent-dev", "git"]
  rollback_on_error false
  action :force_deploy

  environment :SETTINGS_FLAVOR => node['docker-registry']['flavor']

  before_restart do
    template "#{new_resource.path}/current/config.yml" do
      source "config.yml.erb"
    end
  end

  gunicorn do
    requirements "requirements.txt"
    max_requests node['docker-registry']['max_requests']
    timeout node['docker-registry']['timeout']
    host "localhost"
    port node['docker-registry']['internal_port']
    workers node['docker-registry']['workers']
    worker_class "gevent"
    app_module "wsgi:application"
  end

  #nginx_load_balancer do
  #end
end
