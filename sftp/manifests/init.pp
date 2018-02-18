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
    file { '/srv/sftp/upload':
        ensure => 'directory',
        mode   => '0777'
    }   
    # for our user
    file { '/srv/sftp/download':
        ensure => 'directory',
        mode   => '0777'
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
