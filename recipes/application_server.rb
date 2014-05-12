#
# Cookbook Name:: docker-registry
# Recipe:: application_server
# Author:: Raul E Rangel (<Raul.E.Rangel@gmail.com>)
#
# Copyright 2014, Raul E Rangel
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

node.default['docker-registry']['application_server'] = true

include_recipe "docker-registry"
