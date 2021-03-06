# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Recipe:: dunst
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

include_recipe 'elite::dotfiles'

['dunst', 'alsa-utils', 'libnotify-bin'].each do |pkg|
  package pkg
end

node['elite']['users'].each do |u|
  dunst = user_config(u, 'dunst')
  next unless dunst
  elite_dunst u do
    user u
    vars node['dunst']
  end
end
