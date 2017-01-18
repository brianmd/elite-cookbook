# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: zsh
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
  package 'zsh'

  template "#{node['elite'][user]['dotfd']}/zshrc" do
    owner user
    group node['elite'][user]['group']
    mode '0640'
    source new_resource.source
    variables config: new_resource.config,
              plugins: new_resource.plugins,
              completions: new_resource.completions,
              theme: new_resource.theme
  end

  directory "#{node['elite'][user]['dotfd']}/zsh.d" do
    owner user
    group node['elite'][user]['group']
    mode '0750'
  end

  cookbook_file "#{node['elite'][user]['dotfd']}/zsh.d/init.zsh" do
    owner user
    group node['elite'][user]['group']
    mode '0640'
    source 'zsh.d/init.zsh'
  end

  remote_directory "#{node['elite'][user]['dotfd']}/zsh.d/lib" do
    owner user
    group node['elite'][user]['group']
    mode '0750'
    files_owner user
    files_group node['elite'][user]['group']
    files_mode '0640'
    source 'zsh.d/lib'
  end

  new_resource.plugins.each do |p|
    elite_zsh_plugin "#{user}-#{p}" do
      user user
      plugin p
    end
  end

  new_resource.completions.each do |c|
    elite_zsh_completion "#{user}-#{c}" do
      user user
      completion c
    end
  end

  elite_zsh_theme "#{user}-#{new_resource.theme}" do
    user user
    theme new_resource.theme
  end

  %w(zshrc zsh.d).each do |l|
    elite_dotlink l do
      owner user
    end
  end

  new_resource.updated_by_last_action(true)
end