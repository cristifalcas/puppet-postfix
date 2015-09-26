class postfix (
  $ensure                = 'latest',
  $smtp_endpoint_address = "smtp.${::domain}",
  $smtp_endpoint_port    = '25',
  $smtp_endpoint_user    = undef,
  $smtp_endpoint_pass    = undef,
  $from_domain           = $::domain,
  $from_user             = 'donotreply',
  $forward_all_email_to  = undef,
  $debug                 = false,
  $use_tls               = false,
  $remove_other_mta      = false,
  $set_alternatives      = true,) {
  contain postfix::install
  contain postfix::config
  contain postfix::service

  Class['postfix::install'] ->
  Class['postfix::config'] ~>
  Class['postfix::service']

	  class { 'postfix':
	    ensure                => 'latest',
	    smtp_endpoint_address => "smtp.${::domain}",
	    smtp_endpoint_port    => '25',
	    smtp_endpoint_user    => undef,
	    smtp_endpoint_pass    => undef,
	    from_domain           => $::domain,
	    from_user             => 'donotreply',
	    forward_all_email_to  => undef,
	    debug                 => false,
	    use_tls               => false,
	    remove_other_mta      => false,
	    set_alternatives      => true,
	  }
}
