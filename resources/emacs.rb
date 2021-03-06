# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Resource:: emacs
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
resource_name :elite_emacs

attribute :name, kind_of: String
attribute :user, kind_of: String, name_attribute: true
attribute :cookbook, kind_of: String, default: 'elite'
attribute :repository, kind_of: String, default: 'https://github.com/Sliim/emacs.d.git'
attribute :reference, kind_of: String, default: 'master'
attribute :apps_repository, kind_of: String, default: 'https://github.com/Sliim/emacs-apps.git'
attribute :apps_reference, kind_of: String, default: 'master'
attribute :apps_dependencies, kind_of: Array, default: []
attribute :apps, kind_of: Hash, default: {}
