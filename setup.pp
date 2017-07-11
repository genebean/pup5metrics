yumrepo { 'grafana':
  ensure        => 'present',
  baseurl       => 'https://packagecloud.io/grafana/stable/el/7/$basearch',
  descr         => 'grafana',
  enabled       => '1',
  gpgcheck      => '1',
  gpgkey        => 'https://packagecloud.io/gpg.key https://grafanarel.s3.amazonaws.com/RPM-GPG-KEY-grafana',
  repo_gpgcheck => '1',
  sslcacert     => '/etc/pki/tls/certs/ca-bundle.crt',
  sslverify     => '1',
}

package { 'grafana':
  ensure  => 'latest',
  require => Yumrepo['grafana'],
}

service { 'grafana-server':
  ensure  => 'running',
  enable  => 'true',
  require => Package['grafana'],
}

class {'::influxdb::server':
  graphite_options => {
    enabled           => true,
    database          => graphite,
    bind-address      => ':2002',
    protocol          => tcp,
    consistency-level => 'one',
    name-separator    => '.',
    batch-size        => 1000,
    batch-pending     => 5,
    batch-timeout     => '1s',
    udp-read-buffer   => 0,
    name-schema       => 'type.host.measurement.device',
    templates         => [ "*.app env.service.resource.measurement" ],
    tags              => [ "region=us-east", "zone=1c"],
  },
}

include ::graphite

