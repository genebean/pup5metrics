Vagrant.configure('2') do |config|
  config.vm.box = 'genebean/centos-7-puppet5'
  config.vm.network 'forwarded_port', guest: 80,   host: 8080
  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'forwarded_port', guest: 8140, host: 8140
  config.vm.provider 'virtualbox' do |v|
    v.memory = 3072
    v.cpus = 2
  end
  config.vm.provision 'shell', inline: <<-EOL
    puppet resource package puppetserver ensure=present
  EOL
  config.vm.provision 'shell', inline: <<-EOL
    puppet resource package rsync ensure=present
    puppet resource service puppetserver.service ensure=running enable=true
    puppet module install golja-influxdb --version 4.0.0
    puppet module install dwerder-graphite --version 7.1.0
    puppet apply /vagrant/setup.pp
    rsync -v /vagrant/metrics.conf /etc/puppetlabs/puppetserver/conf.d/metrics.conf
    rsync -v /vagrant/grafana.db /var/lib/grafana/grafana.db
    rsync -v /vagrant/sfdbconfig.conf /etc/sfdbconfig.conf
    chown grafana:grafana /var/lib/grafana/grafana.db
    systemctl restart grafana-server
    curl -s https://raw.githubusercontent.com/signalfx/metricproxy/master/install.sh | sh
    puppet resource service metricproxy ensure=running enable=true
    systemctl restart puppetserver.service
  EOL
end
