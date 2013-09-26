name              "docker-registry"
maintainer        "Raul E Rangel"
maintainer_email  "Raul.Rangel@Disney.com.com"
license           "Apache 2.0"
description       "Installs and configures docker-registry"
version           "0.0.3"

recipe "docker-registry", "Installs the docker-registry and sets up configuration"

# TODO: debian centos redhat amazon scientific oracle fedora 
%w{ ubuntu smartos }.each do |os|
  supports os
end

%w{ application_nginx application_python }.each do |cb|
  depends cb
end

depends 'application', '>= 3.0.0'

attribute "docker-registry/repository",
  :display_name => "Docker Registry Git Repo",
  :description => "The URL for the Docker Registry Git Repo",
  :type => "string",
  :required => "required",
  :default => "https://github.com/dotcloud/docker-registry.git"

attribute "docker-registry/revision",
  :display_name => "Docker Registry Revision",
  :description => "The revision to check out from the repository",
  :type => "string",
  :required => "required"

attribute "docker-registry/install_dir",
  :display_name => "Docker Registry Install Directory",
  :description => "The directory to install Docker Registry",
  :type => "string",
  :required => "required",
  :default => "/opt/docker-registry"

#TODO: Fill in the rest... for some reason?

attribute "docker-registry/data_bag",
  :display_name => "Data Bag containing secrets",
  :description => "The data bag that contains environment files with ssl and s3 keys",
  :type => "string",
  :required => "recommended"
