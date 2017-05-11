# -*- coding: utf-8 -*-
#
# Cookbook Name:: elite
# Spec:: slim
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

require_relative 'spec_helper'

describe 'elite::slim' do
  let(:subject) do
    ChefSpec::SoloRunner.new(platform: 'debian',
                             version: '8.0') do |node|
      node.override['elite']['users'] = %w(sliim foo)
      node.override['elite']['groups'] = %w(elite)
      node.override['elite']['slim']['user'] = 'sliim'
      node.override['elite']['slim']['theme'] = 'airlines'
      node.override['elite']['slim']['session'] = 'devsession'
      node.override['elite']['slim']['additional_themes'] = {
        'airlines' => {
          'repository' => 'https://github.com/aur-archive/slim-theme-airlines',
          'reference' => 'master',
        },
      }
    end.converge(described_recipe)
  end

  it 'installs package[slim]' do
    expect(subject).to install_package('slim')
  end

  it 'creates template[/etc/slim.conf]' do
    config_file = '/etc/slim.conf'
    matches = [start_with('# Generated by Chef!'),
               /^default_user\s+sliim$/,
               %r{^login_cmd\s+exec /bin/bash -login /etc/X11/Xsession devsession$},
               /^current_theme\s+airlines$/]

    expect(subject).to create_template(config_file)
      .with(source: 'slim.conf.erb',
            owner: 'root',
            group: 'root',
            mode: '0644')

    matches.each do |m|
      expect(subject).to render_file(config_file).with_content(m)
    end
  end

  it 'creates directory[/usr/share/slim/themes]' do
    expect(subject).to create_directory('/usr/share/slim/themes')
      .with(owner: 'root',
            group: 'root',
            mode: '0755',
            recursive: true)
  end

  it 'syncs git[/usr/share/slim/themes/airlines]' do
    expect(subject).to sync_git('/usr/share/slim/themes/airlines')
      .with(user: 'root',
            group: 'root',
            repository: 'https://github.com/aur-archive/slim-theme-airlines',
            reference: 'master')
  end

  it 'creates file[/etc/X11/default-display-manager]' do
    expect(subject).to create_file('/etc/X11/default-display-manager')
      .with(content: '/usr/bin/slim',
            owner: 'root',
            group: 'root',
            mode: '0644')
  end

  it 'creates link[/lib/systemd/system/display-manager.service]' do
    expect(subject).to create_link('/lib/systemd/system/display-manager.service')
      .with(link_type: :symbolic,
            to: '/lib/systemd/system/slim.service',
            owner: 'root',
            group: 'root')
  end
end
