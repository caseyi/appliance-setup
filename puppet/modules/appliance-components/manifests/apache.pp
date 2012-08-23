class appliance-components::apache {
  include ::apache
  include ::apache::mod::ssl
  include ::apache::mod::proxy
  include ::apache::mod::proxy_http

  file { '/etc/apache2/sites-enabled/default-ssl':
    ensure  => link,
    target  => '/etc/apache2/sites-available/default-ssl',
    require => [
      Package['httpd'],
      Package['ssl-cert'],
    ],
    notify  => Service['httpd'],
  }

  package { 'ssl-cert':
    ensure => installed,
  }
}