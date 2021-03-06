# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: dotfiles
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

include_recipe 'elite::default'

node['elite']['users'].each do |u|
  next unless node['elite'].key?(u)
  dotfiles = user_config(u, 'dotfiles') || {}
  elite_dotfiles u do
    mode dotfiles['mode'] if dotfiles['mode']
    cookbook dotfiles['cookbook'] if dotfiles['cookbook']
    source dotfiles['source'] if dotfiles['source']
    ignore dotfiles['ignore'] if dotfiles['ignore']
    init_repo dotfiles['init_repo'] if dotfiles['init_repo']
  end
end
