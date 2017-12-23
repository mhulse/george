# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = 'ubuntu/trusty64'
  
  config.vm.provider 'virtualbox' do |vb|
    
    # Boost memory usage to 8GB:
    vb.customize [
      'modifyvm',
      :id,
      '--memory',
      8192
    ]
    
    # CPU usage:
    vb.customize [
      'modifyvm',
      :id,
      '--cpus',
      2
      # Set half of available CPU count:
      #`awk "/^processor/ {++n} END {print n}" /proc/cpuinfo 2> /dev/null || sh -c 'sysctl hw.logicalcpu 2> /dev/null || echo ": 2"' | awk \'{print \$2}\' `.chomp
    ]
    
  end
  
  # Shared directory configuration defaults:
  synced_folder_defaults = {
    create: true,
    owner: 'vagrant',
    group: 'vagrant',
    mount_options: [
      'dmode=775',
      'fmode=664',
    ],
  }
  
  # Disable the default share:
  config.vm.synced_folder(
    '.',
    '/vagrant', {
      id: 'vagrant-root',
      disabled: true,
    }
  )
  
  # Give sync access to host machine:
  config.vm.synced_folder(
    './neural-style',
    '/home/vagrant/neural-style',
    synced_folder_defaults.merge!({
      id: 'neural-style',
    })
  )
  
  # Run provisioning script:
  config.vm.provision(
    'shell',
    {
      # Run as vagrant, not root:
      path: 'bootstrap.sh',
      privileged: false,
      args: [
        # Pass arguments here …
      ]
    }
  )

end
