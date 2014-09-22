#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright (C) 2014 Atsushi Nakajyo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
node.set['java']['jdk_version'] = '7'
node.set['java']['install_flavor'] = 'openjdk'

include_recipe "java"

# --- elasticsearch ---
log "-> Install elasticsearch"

yum_repository "elasticsearch-1.3" do
    description "Elasticsearch repository for 1.3.x packages"
    baseurl "http://packages.elasticsearch.org/elasticsearch/1.3/centos"
    gpgcheck true
    gpgkey "http://packages.elasticsearch.org/GPG-KEY-elasticsearch"
    action :create
end

package "elasticsearch" do
    action :install
end

log "->> Setting elasticsearch"
template "/etc/elasticsearch/elasticsearch.yml" do
    owner "root"
    group "root"
    mode "0644"
    variables({
        :cluster_name => node['elasticsearch']['cluster']['name'],
        :node_name => node['elasticsearch']['node']['name']
    })
end

service "elasticsearch" do
    supports :status => true, :restart => true, :relaod => true
    action [:enable, :start]
end

# --- virtual memory
log "-> Setting virtual memory"
node.set['sysctl']['params']['vm']['max_map_count'] = 262144
include_recipe "sysctl::apply"
