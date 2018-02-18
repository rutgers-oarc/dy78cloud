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
        mode   => '0644',
        source => 'puppet:///modules/sftp/etc/ssh/sshd_config',
    }   
    file { '/srv/sftp':
        ensure => 'directory',
        mode   => '0701',
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
    file { '/srv/sftp/dy78/upload':
        ensure => 'directory',
        mode   => '0701',
    }   
    file { '/srv/sftp/dy78/download':
        ensure => 'directory',
        mode   => '0704',
    }   

    user { 'dyang' :
        groups            => 'sftpuser',
    }
    file { '/srv/sftp/dyang/upload':
        ensure => 'directory',
        mode   => '0701',
    }   
    file { '/srv/sftp/dyang/download':
        ensure => 'directory',
        mode   => '0704',
    }   

    user { 'ericmars' :
        groups            => 'sftpuser',
    }
    file { '/srv/sftp/ericmars/upload':
        ensure => 'directory',
        mode   => '0701',
    }   
    file { '/srv/sftp/ericmars/download':
        ensure => 'directory',
        mode   => '0704',
    }   
}
