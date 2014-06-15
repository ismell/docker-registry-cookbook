Description
===========

This cookbook deployes the dotCloud [docker-registry](https://github.com/dotcloud/docker-registry)

Requirements
============

Chef 0.10.0 or higher required (for Chef environment use).

Cookbooks
---------

* application_nginx
* application_python

Platform
--------

* Ubuntu
* SmartOS
* CentOS (Requires supervisor cookbook >= 0.4.11)

Attributes
==========

See `attributes/default.rb` for default values.

* `node["docker-registry"]["revision"]` - Git tag to install.
* `node["docker-registry"]["storage"]` - Defines the type of storage to use, local or s3.
* `node["docker-registry"]["ssl"]` - If ssl should be enabled.
* `node["docker-registry"]["server_name"]` - The FQDN that NGiNX will proxy for.
* `node["docker-registry"]["data_bag"]` - Name of data bag containing encrypted secrets.
* `node["docker-registry"]["s3_access_key"]` - Your S3 Access Key.
* `node["docker-registry"]["s3_bucket"]` - Your S3 storage bucket.
* `node["docker-registry"]["secret_key"]` - A 64 character random string. This is used to secure the session cookie. It is recommended to store this in the encrypted data bag.

Data Bag
==========

To enable SSL or use S3 as a storage backend a data bag must be created to store the secrets. The data bag should contain an item for each environment that will host the `docker-registry`.

    $ knife data bag show BAG_NAME ENVIRONMENT --secret-file=my-secret-file
    {
      "id": "ENVIRONMENT",
      "secret_key": "...",
      "ssl_certificate": [
        "....", # SSL Certificate Chain
        "....",
        "...." 
      ],
      "ssl_certificate_key": "...",
      "s3_secret_key": "..."
    }

The `ssl_certificate` should contain the entire Certificate chain starting with the server certificate. The values should not contain any new lines. You can do this with `cat my_cert.crt | tr -d '\r\n'`.

Roles
=====

docker-registry
---------------

A helper role that will configure a server to act as both an application server and load balancer.


docker-registry_application-server
----------------------------------

Applying this role will install the docker-registry


docker-registry_load_balancer
-----------------------------

Applying this role will install and configure NGiNX to proxy to all application servers.

The docker-registry_load_balancer role included in the repo will install the latest NGiNX from source. Ubuntu includes an ancient version that won't work with the registry.


License and Author
==================

Author:: Raul E Rangel (<Raul.E.Rangel@gmail.com>)

Copyright 2014, Raul E Rangel.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
