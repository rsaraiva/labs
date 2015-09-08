class loja_virtual::ci {

	exec { "apt-update":
		command => "/usr/bin/apt-get update"
	}

	package { ['git', 'maven2', 'openjdk-6-jdk']:
		ensure => "installed",
		require => Exec["apt-update"],
	}

	class { 'jenkins':
		config_hash => {
			'JAVA_ARGS' => { 'value' => '-Xmx256m' }
		},
	}

	$plugins = [
		'ssh-credentials',
		'credentials',
		'scm-api',
		'git-client',
		'git',
		'maven-plugin',
		'javadoc',
		'mailer',
		'greenballs',
		'ws-cleanup'
	]

	jenkins::plugin { $plugins: }
}
