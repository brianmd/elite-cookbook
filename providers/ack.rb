# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: ack
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
  package 'ack-grep'

  template "#{node['elite'][user]['dotfd']}/ackrc" do
    owner user
    group node['elite'][user]['group']
    mode new_resource.mode
    source new_resource.source
    cookbook new_resource.cookbook
    variables lines: new_resource.config
  end

  elite_dotlink 'ackrc' do
    owner user
  end

  new_resource.updated_by_last_action(true)
end