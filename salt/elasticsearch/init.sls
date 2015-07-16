include:
  - java

elasticsearch_repo:
    pkgrepo.managed:
        - humanname: Elasticsearch Official Debian Repository
        - name: deb http://packages.elasticsearch.org/elasticsearch/1.6/debian stable main
        - dist: stable
        - key_url: salt://elasticsearch/keys/GPG-KEY-elasticsearch
        - file: /etc/apt/sources.list.d/elasticsearch.list

/var/run/elasticsearch:
  file.directory

elasticsearch:
  pkg:
    - installed
    - require:
      - pkg: oracle-java7-installer
      - pkgrepo: elasticsearch_repo
  service:
    - running
    - require:
      - pkg: elasticsearch
      - file: /var/run/elasticsearch

kopf_plugin:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/plugin --install lmenezes/elasticsearch-kopf/1.6
    - unless: test -d /usr/share/elasticsearch/plugins/kopf
  require:
    - pkg: elasticsearch

kopf_external_settings:
  file.managed:
    - name: /usr/share/elasticsearch/plugins/kopf/_site/kopf_external_settings.json
    - source: salt://elasticsearch/config/kopf_external_settings.json
    - mode: 644
    - template: jinja
    - require:
      - cmd: kopf_plugin