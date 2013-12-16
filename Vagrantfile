# -*- mode: ruby -*-
# vi: set ft=ruby :

confucius_root = ENV['CONFUCIUS_ROOT']
unless confucius_root
  warn "[\e[1m\e[31mERROR\e[0m]: Please set the 'CONFUCIUS_ROOT' " +
       'environment variable to point to the confucius repo'
  exit 1
end

default = {
  :user => ENV['OPSCODE_USER'] || ENV['USER'],
  :project => File.basename(Dir.getwd),
  :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
  :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
}

Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-omnibus'

Vagrant.configure('2') do |config|
  config.vm.box = 'opscode-ubuntu-12.04'
  config.vm.box_url = 'https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box'
  
  config.berkshelf.enabled = true

  config.omnibus.chef_version = :latest

  config.cache.auto_detect = true
  # if you are using virtualbox, you might want to enable nfs for shared folders
  #config.cache.enable_nfs  = true

  # NOTE: enable SSH agent forwarding for git clones
  config.ssh.forward_agent = true

  config.vm.hostname = 'localhost'
  
  config.vm.provider :virtualbox do |vb|
#      vb.gui = true
      vb.customize ['modifyvm', :id, '--cpus', 2]
      vb.customize ['modifyvm', :id, '--memory', 1024]
  end
  
  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug

    chef.data_bags_path = "#{confucius_root}/data_bags"

    chef.json = {
        :balanced_env => 'vagrant',
        :message_broker => '10.0.2.2',
        :citadel => {
            'newrelic/license_key' => nil,
            'access_key_id' => default[:access_key_id],
            'secret_access_key' => default[:secret_access_key]
        }
    }
    
    chef.run_list = [
        "recipe[#{default[:project]}]"
    ]
  end

end
