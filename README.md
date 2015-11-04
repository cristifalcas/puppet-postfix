# postfix #
[![Build Status](https://travis-ci.org/cristifalcas/puppet-postfix.png?branch=master)](https://travis-ci.org/cristifalcas/puppet-postfix)

This is the postfix module. Currently it is mostly used to set up the local machine as a relay
that forwards all emails to a local smtp server.

Usage:

Forward all wmails to your local friendlt company server:

      class { 'postfix':
	    ensure                => 'latest',
	    smtp_endpoint_address => "smtp.${::domain}",
	    smtp_endpoint_port    => '25',
	    smtp_endpoint_user    => undef,
	    smtp_endpoint_pass    => undef,
	    # make emails appear as sent from this domain
	    from_domain           => $::domain,
	    # make emails appear as sent from this user
	    from_user             => 'donotreply',
	    # forward all local emails to this user also
	    forward_all_email_to  => undef,
	    # remove other mail servers
	    remove_other_mta      => true,
	    set_alternatives      => true,
	  }

Amazon:

	  class { 'postfix':
	    ensure                => 'latest',
	    smtp_endpoint_address => 'email-smtp.us-east-1.amazonaws.com',
	    # amazon needs tls (this uses puppet certificates)
	    use_tls               => true,
	    smtp_endpoint_port    => '2587',
	  }

Use an user and a password to authenticate to the proper email server:

	  class { 'postfix':
	    ensure                => 'latest',
	    smtp_endpoint_port    => '25',
	    smtp_endpoint_user    => 'login_user',
	    smtp_endpoint_pass    => 'pass_user',
	  }
