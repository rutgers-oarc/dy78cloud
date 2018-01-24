node default {
        class { 'ntp':
                servers => [ 'time1.google.com', 'time3.google.com' ],
        }
        package { 'mailx' :
                ensure  => 'installed',
        }
}
node /^instance-\d+$/ {
        include local
        file { '/mnt/data':
                ensure => 'directory',
                mode   => '0777'
        }
        class { '::nfs':
                server_enabled => true,
        }
        Nfs::Client::Mount <<| |>>
}
node  /^master.*internal$/ {
        class { 'ntp':
                servers => [ 'time1.google.com', 'time3.google.com' ],
        }
# UUID=6fe2ecf5-ef0d-4637-a379-ec57839f6a57 /mnt/disks/data ext4 discard,defaults,nofail 0 2
        class { '::nfs':
                server_enabled => true,
        }
        nfs::server::export{ '/mnt/data':
                ensure  => 'mounted',
                #clients => '10.0.0.0/24(rw,insecure,async,no_root_squash) localhost(rw)'
                clients => '*.c.ru-tensor-time-series.internal(rw,insecure,async,no_root_squash) localhost(rw)'
        }
        service { 'slurmctld' :
               subscribe => File['masterslurm.conf'],
               ensure  => 'running',
        }  
        file { 'masterslurm.conf':
                ensure  => 'file',
                path    => '/etc/slurm/slurm.conf',
                mode    => '0644',
                source  =>  'puppet:///modules/local/slurm.conf',
                before  =>  Service['slurmctld'],
        }
        user { 'slurm': uid => 996,}
        file { 'mastercgroup.conf':
                ensure  => 'file',
                mode    => '0400',
                path    => '/etc/slurm/cgroup.conf',
                source  =>  'puppet:///modules/local/cgroup.conf',
                before =>  Service['slurmctld'],
        }
}
