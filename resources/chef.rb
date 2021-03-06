# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: chef
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

actions :create
default_action :create
resource_name :elite_chef

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :mode, kind_of: String, default: '0640'
attribute :cookbook, kind_of: String, default: 'elite'
attribute :client_source, kind_of: String, default: 'chef/knife.rb.erb'
attribute :stove_source, kind_of: String, default: 'chef/stove.erb'
attribute :client_key_path, kind_of: String, default: nil
attribute :node_name, kind_of: String, default: 'sliim'
attribute :chef_server_url, kind_of: String, default: nil
