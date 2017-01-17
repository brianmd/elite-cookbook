# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: git
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

use_inline_resources

def whyrun_supported?
  true
end

action :create do
  user = new_resource.user

  package 'git'

  template "#{node['elite'][user]['dotfd']}/gitconfig" do
    owner user
    group node['elite'][user]['group']
    mode new_resource.mode
    source new_resource.gitconfig_src
    cookbook new_resource.cookbook
    variables name: new_resource.username,
              email: new_resource.email
  end

  template "#{node['elite'][user]['dotfd']}/gitignore" do
    owner user
    group node['elite'][user]['group']
    mode new_resource.mode
    source new_resource.gitignore_src
    cookbook new_resource.cookbook
    variables files: new_resource.gitignore
  end

  elite_dotlink 'gitconfig' do
    owner user
  end

  elite_dotlink 'gitignore' do
    owner user
  end

  new_resource.updated_by_last_action(true)
end
