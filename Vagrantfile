# -*- mode: ruby -*-
# vim: set ft=ruby :


MACHINES = {
    :inetRouter => {
        :box_name => "centos/8",
        :memory => 512,
        :net => [
                #   {ip: '192.168.250.1', adapter: 2, netmask: "255.255.255.0"},
                  {ip: '192.168.255.1', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
                ]
  },
    :mysql => {
        :box_name => "centos/7",
        :memory => 1024,
        :net => [
               {ip: '192.168.255.3', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
            ]
},
    :slave => {
        :box_name => "centos/7",
        :memory => 1024,
        :net => [
            {ip: '192.168.255.4', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
            ]
},
    :web => {
        :box_name => "centos/8",
        :memory => 512,
        :net => [
                {ip: '192.168.255.2', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
                ]
},

    :backupserver => {
        :box_name => "centos/8",
        :memory => 512,
        :net => [
                {ip: '192.168.255.5', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
                ]
},

    :log => {
        :box_name => "centos/8",
        :memory => 512,
        :net => [
                {ip: '192.168.255.6', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
                ]
},

    :monitoring => {
        :box_name => "centos/8",
        :memory => 1024,
        :net => [
                {ip: '192.168.255.7', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
                ]
},


#     :ldap => {
#         :box_name => "centos/8",
#         :memory => 2048,
#         :net => [
#                 {ip: '192.168.255.6', adapter: 2, netmask: "255.255.255.0", virtualbox__intnet: "local"},
#                 ]
# },


}

Vagrant.configure("2") do |config|

    MACHINES.each do |boxname, boxconfig|

        config.vm.define boxname do |box|

            box.vm.box = boxconfig[:box_name]
            box.vm.host_name = boxname.to_s

            boxconfig[:net].each do |ipconf|
            box.vm.network "private_network", ipconf
            end
            box.vm.provider :virtualbox do |vb|
                vb.customize ["modifyvm", :id, "--memory", boxconfig[:memory]]
                end
                          
            case boxname.to_s
            when "web"
                box.vm.network "forwarded_port", guest: 443, host: 8080
                # box.vm.network "forwarded_port", guest: 8065, host: 8081
            when "ldap"
                box.vm.network "forwarded_port", guest: 80, host: 8082
                box.vm.hostname = "ipa-server.otus.local"
            when "monitoring"
                box.vm.network "forwarded_port", guest: 3000, host: 8888
                box.vm.network "forwarded_port", guest: 9090, host: 8899
            when "inetRouter"
                box.vm.network "forwarded_port", guest: 443, host: 8083
                # box.vm.network "forwarded_port", guest: 8065, host: 8081
            end


            box.vm.provision :ansible do |ansible|
                ansible.playbook = "./playbook.yml"
                # ansible.verbose = true
              end
            
            
        end
    end  

end