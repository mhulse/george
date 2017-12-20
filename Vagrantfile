# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  
  config.vm.box = 'ubuntu/trusty64'
  
  config.vm.provider 'virtualbox' do |vb|
    
    # Boost memory usage to 6GB:
    vb.customize [
      'modifyvm',
      :id,
      '--memory',
      6144
    ]
    
    # CPU usage:
    vb.customize [
      'modifyvm',
      :id,
      '--cpus',
      2
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
      path: 'bootstrap.sh',
      args: [
        # Pass arguments here …
      ]
    }
  )

end
