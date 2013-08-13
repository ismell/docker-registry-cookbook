name              "docker-registry"
maintainer        "Raul E Rangel"
maintainer_email  "Raul.Rangel@Disney.com.com"
license           "Apache 2.0"
description       "Installs and configures docker-registry"
version           "0.0.2"

recipe "docker-registry", "Installs the docker-registry and sets up configuration"

# TODO: debian centos redhat amazon scientific oracle fedora 
%w{ ubuntu }.each do |os|
  supports os
end

%w{ application_nginx application_python}.each do |cb|
  depends cb
end

#%w{ bluepill }.each do |cb|
#  suggests cb
#end

attribute "registry/flavor",
  :display_name => "Flavor",
  :description => "Flavor to run common, dev, prod",
  :default => "dev"

