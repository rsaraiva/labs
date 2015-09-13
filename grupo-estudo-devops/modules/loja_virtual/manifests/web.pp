class loja_virtual::web {

    include mysql::client
    include loja_virtual
    include loja_virtual::params

    file { $loja_virtual::params::keystore_file:
        group => root, #tomcat7, #FIXME
        mode => 644, #0640, #FIXME
        source => "puppet:///modules/loja_virtual/.keystore",
        notify => Service["tomcat7"],
    }

    class { 'tomcat::server':
        connectors => [$loja_virtual::params::ssl_connector],
        data_sources => {
            "jdbc/web"     => $loja_virtual::params::db,
            "jdbc/secure"  => $loja_virtual::params::db,
            "jdbc/storage" => $loja_virtual::params::db,
        },
        require => File[$loja_virtual::params::keystore_file],
    }

    apt::source { 'devopsnapratica':
        location=> 'http://192.168.33.30/',
        release=> 'devopspkgs',
        repos=> 'main',
        key=> '4F3FD614',
        key_source=> 'http://192.168.33.30/devopspkgs.gpg',
        include_src=> false,
    }

    package { 'devopsnapratica':
        ensure => 'latest',
        notify => Service['tomcat7'],
    }
}
