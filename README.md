[![Build Status](https://travis-ci.com/trydirect/sylius.svg?branch=1.5.2)](https://travis-ci.com/trydirect/sylius)
![Docker Stars](https://img.shields.io/docker/stars/trydirect/sylius.svg)
![Docker Pulls](https://img.shields.io/docker/pulls/trydirect/sylius.svg)
![Docker Automated](https://img.shields.io/docker/cloud/automated/trydirect/sylius.svg)
![Docker Build](https://img.shields.io/docker/cloud/build/trydirect/sylius.svg)
[![Gitter chat](https://badges.gitter.im/trydirect/community.png)](https://gitter.im/try-direct/community)

# Sylius development template

Quick deployment of Sylius development environment

## Stack includes
* Sylius 1.5.2
* PHP-fpm 7.2.11
* MySQL 5.7
* Redis latest
* Elasticsearch 5.4.3
* Kibana 5.4.3
* Logstash 5.4.0
* XDebug 2.6.1
* Nginx 
* Supervisord

## Note

Before installing this project, please, make sure you have installed docker and docker-compose 
To install docker execute: 

```sh
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sh get-docker.sh
$ pip install docker-compose
```
## Installation

1. Clone project files:

```sh
$ git clone https://github.com/trydirect/sylius.git
```

2. Bring up the project with following command:

```sh
$ cd sylius
$ ./setup.sh
```

3. Add localdomain to your hosts file Linux, OSX: 

```
echo  "127.0.0.1 localdomain kibana.localdomain" | sudo tee -a /etc/hosts
```

4. Let's check the result 

| URL | App |
| --- | --- |
| http://localdomain | sylius home page |
| http://kibana.localdomain | kibana dashboard |


Default kibana creds:  
- login: admin   
- password:  admin


## Quick deployment to cloud
##### Amazon AWS, Digital Ocean, Hetzner and others
[<img src="https://img.shields.io/badge/quick%20deploy-%40try.direct-brightgreen.svg">](https://try.direct/server/user/deploy/InN5bGl1c3w2fDMwIg.EIJLoA.U55nSFwuA2BqoNB6VDiiJgnmrOI/)



## Contributing

1. Fork it (https://github.com/trydirect/sylius/fork)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request


## Support Development

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2BH8ED2AUU2RL)
