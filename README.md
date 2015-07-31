# salt-elk-celery

Salt scripts to install/configure the ELK stack (Elasticsearch, Logstash, Kibana) on a single VM using Vagrant.
In this setup, Logstash is will only recognize logs as outputted from Celery (http://www.celeryproject.org/),
but could easily be extended to Apache logs, etc.

## Prerequisites

1. Install the latest version of VirtualBox (https://www.virtualbox.org)
2. Install the latest version of Vagrant (https://www.vagrantup.com)

## Setup

1. Clone this repo
2. Run ```vagrant up``` in a terminal from the directory containing this repo's Vagrantfile
3. Wait...
4. Possibly run highstate, see 'Known Issues' below
5. View Kibana in a browser @ http://localhost:8080

Note:

You can also view the cluster's status @ http://localhost:8080/kopf/

## Usage

To get Logstash to parse Celery logs, drop them in the ```logs``` directory which is shared between the host and VM.

## License

MIT