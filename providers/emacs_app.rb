# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Provider:: emacs_app
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
  app = new_resource.app
  config = new_resource.config

  desktop = config['desktop']

  elite_desktop_app "#{user}-#{app}" do
    not_if { desktop.nil? }
    owner user
    app app
    config desktop
  end

  case app
  when 'elfeed'
    feeds = config['feeds']
    template "#{user_dotfiles(user)}/elfeed.el" do
      not_if { feeds.nil? }
      owner user
      group user_group(user)
      mode '0640'
      source 'emacs-apps/elfeed.el.erb'
      variables feeds: feeds
    end

    elite_dotlink "#{user}-elfeed.el" do
      owner user
      file 'elfeed.el'
    end
  end

  new_resource.updated_by_last_action(true)
end