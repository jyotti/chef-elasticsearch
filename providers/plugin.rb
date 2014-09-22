action :install do
    name = @new_resource.name
    version = @new_resource.version
    plugin_bin = "/usr/share/elasticsearch/bin/plugin"

    command_str = "#{plugin_bin} --install #{name}"
    if version != nil
        command_str = "#{command_str}/#{version}"
    end

    component = name.split('/')[1].sub('elasticsearch-','')
    log "component is #{component}"

    execute "install plugin" do
        user "root"
        command command_str
        not_if { ::File.directory?("/usr/share/elasticsearch/plugins/#{component}") }
    end
end

action :uninstall do
    name = @new_resource.name
    plugin_bin = "/usr/share/elasticsearch/bin/plugin"

    command_str = "#{plugin_bin} --remove #{name}"

    component = name.split('/')[1].sub('elasticsearch-','')
    log "component is #{component}"

    execute "uninstall plugin" do
        user "root"
        command command_str
        only_if { ::File.directory?("/usr/share/elasticsearch/plugins/#{component}") }
    end
end
