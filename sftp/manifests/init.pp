class sftp{
    package { 'openssh-server' :
        ensure  => 'installed',
    }   
    package { 'openssh-askpass' :
        ensure  => 'installed',
    }   
    group { 'sftpusers':
        ensure => 'present',
    }   
    file { '/etc/ssh/sshd_config':
        ensure => 'directory',
        mode   => '0777',
        source => 'puppet:///module/sftp/etc/ssh/sshd_config',
    }   
    file { '/srv/sftp/upload':
        ensure => 'directory',
        mode   => '0701',
    }   
    # for our user
    file { '/srv/sftp/download':
        ensure => 'directory',
        mode   => '0701',
    }
    # users
    # dependent on current setup 
    user { 'dy78' :
        groups            => 'sftpuser',
    }
    user { 'dyang' :
        groups            => 'sftpuser',
    }
    user { 'ericmars' :
        groups            => 'sftpuser',
    }
}
