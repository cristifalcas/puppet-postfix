class postfix::config {
  # certificates for postfix
  $cert_owner = 'root'
  $cert_group = 'root'

  if $postfix::set_alternatives {
    alternatives { 'mta':
      path => '/usr/sbin/sendmail.postfix',
      mode => 'manual',
    }
  }

  if $postfix::use_tls {
      $tls_ca_file = '/etc/ssl/certs/ca-bundle.trust.crt'
  }

  # main config
  file { '/etc/postfix/main.cf':
    ensure  => 'file',
    content => template('postfix/main.cf'),
  }

  # rewrite from
  file { '/etc/postfix/sender_canonical':
    ensure  => 'file',
    content => template('postfix/sender_canonical'),
  }

  exec { 'postmap-sender_canonical':
    command     => '/usr/sbin/postmap /etc/postfix/sender_canonical',
    refreshonly => true,
    notify      => Service['postfix'],
  }

  # sasl_passwd
  if $::postfix::smtp_endpoint_user and $postfix::smtp_endpoint_pass {
    $sasl_passwd = 'file'
    $sasl_exec = '/usr/sbin/postmap hash:/etc/postfix/sasl_passwd'
  } else {
    $sasl_passwd = 'absent'
    $sasl_exec = '/bin/true'
  }

  file { '/etc/postfix/sasl_passwd':
    ensure    => $sasl_passwd,
    owner     => 'root',
    group     => 'root',
    mode      => '0600',
    content   => template('postfix/sasl_passwd'),
    show_diff => false,
    notify    => Exec['postfix-make-sasl_passwd'],
  }

  exec { 'postfix-make-sasl_passwd':
    command     => $sasl_exec,
    refreshonly => true,
    notify      => Service['postfix'],
    before      => File['/etc/postfix/sasl_passwd.db'],
  }

  file { '/etc/postfix/sasl_passwd.db':
    ensure => $sasl_passwd,
    owner  => 'root',
    group  => 'root',
    mode   => '0600',
  }
}
