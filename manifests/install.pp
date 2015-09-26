class postfix::install {
  package { ['postfix', 'cyrus-sasl-plain']:
    ensure   => $::postfix::ensure,
    provider => 'yum',
  }

  if $::postfix::remove_other_mta {
    service { 'sendmail':
      ensure => stopped,
      enable => false,
    } ->
    package { ['sendmail', 'procmail', 'sendmail-cf']:
      ensure   => 'purged',
      provider => 'yum',
    }
  }
}
