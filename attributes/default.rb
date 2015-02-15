#
# Cookbook Name:: docker-registry
# Attributes:: default
#
# Author:: Raul E Rangel (<Raul.E.Rangel@gmail.com>)
#
# Copyright 2013, Raul E Rangel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['docker-registry']['repository'] = "https://github.com/dotcloud/docker-registry.git"
default['docker-registry']['revision'] = "0.6.8"

default['docker-registry']['install_dir'] = "/opt/docker-registry"

default['docker-registry']['owner'] = "docker-registry"
default['docker-registry']['group'] = "docker-registry"
default['docker-registry']['create_user_and_group'] = true

default['docker-registry']['internal_port'] = 5000
default['docker-registry']['workers'] = 8
default['docker-registry']['max_requests'] = 100
default['docker-registry']['timeout'] = 3600

default['docker-registry']['flavor'] = 'dev'
default['docker-registry']['secret_key'] = nil

default['docker-registry']['standalone'] = true
default['docker-registry']['index_endpoint'] = 'https://index.docker.io'

default['docker-registry']['storage'] = 'local'
default['docker-registry']['storage_path'] = '/var/lib/docker-registry'

default['docker-registry']['ssl'] = false
default['docker-registry']['ssl_path'] = '/etc/ssl'

default['docker-registry']['certificate_path'] = nil
default['docker-registry']['certificate_key_path'] = nil

default['docker-registry']['server_name'] = nil
default['docker-registry']['application_server_role'] = 'docker-registry_application_server'

case node['platform']
  when 'ubuntu'
    default['docker-registry']['packages'] = %w(libevent-dev git libffi-dev liblzma-dev)
    if node['platform_version'].to_f >= 14.04
      # Ubuntu 14.04 needs gcc to install some py deps
      default['docker-registry']['packages'] << 'libssl-dev'
      default['docker-registry']['packages'] << 'gcc'
    end
  when 'centos','rhel'
    default['docker-registry']['packages'] = %w(gcc git libevent-devel libffi-devel openssl-devel xz-devel)
  when 'smartos'
    default['docker-registry']['packages'] = %w(libevent scmgit)
end
