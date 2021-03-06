# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: tmux_script
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
  user = new_resource.owner
  workdir = new_resource.workdir
  workdir = user_home(user) if workdir.empty?

  template new_resource.path do
    owner user
    group user_group(user)
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables script: new_resource,
              workdir: workdir,
              name: new_resource.name,
              windows: new_resource.windows,
              default_window: new_resource.default_window
  end
end
