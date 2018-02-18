class local{
        package { 'R' :
                ensure  => 'installed',
        }
        package { 'ohpc-slurm-client' :
                ensure  => 'installed',
                before  => [File['/etc/slurm/slurm.conf'], File['/etc/munge/munge.key']], 
        }
        user { 'slurm': uid => 996,}
        file { '/etc/slurm/slurm.conf':
                ensure  => 'file',
                mode    => '0644',
                source  =>  'puppet:///modules/local/slurm.conf',
                before =>  Service['slurmd'],
        }   
        file { '/etc/munge/munge.key':
                ensure  => 'file',
                mode    => '0400',
                source  =>  'puppet:///modules/local/munge.key',
                before =>  Service['slurmd'],
        }   
        file { '/etc/slurm/cgroup.conf':
                ensure  => 'file',
                mode    => '0400',
                source  =>  'puppet:///modules/local/cgroup.conf',
                before =>  Service['slurmd'],
        }   
        service { 'slurmd' :
                ensure  => 'running',
        }
        service { 'munge' :
               ensure  => 'running',
               before =>  Service['slurmd'],
        }  
}
