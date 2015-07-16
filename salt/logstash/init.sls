include:
  - elasticsearch

logstash_repo:
    pkgrepo.managed:
        - humanname: Logstash Official Debian Repository
        - name: deb http://packages.elasticsearch.org/logstash/1.5/debian stable main
        - dist: stable
        - key_url: salt://elasticsearch/keys/GPG-KEY-elasticsearch
        - file: /etc/apt/sources.list.d/logstash.list

logstash:
  pkg:
    - installed
    - require:
      - pkg: elasticsearch
      - pkgrepo: logstash_repo
  service:
    - running
    - require:
      - pkg: logstash
    - watch:
      - file: /etc/logstash/conf.d/syslog_celery.conf
      - file: /etc/default/logstash

/etc/default/logstash:
  file.managed:
    - source: salt://logstash/config/logstash_settings
    - mode: 644
    - template: jinja
    - require:
      - pkg: logstash

/etc/logstash/conf.d/syslog_celery.conf:
  file.managed:
    - source: salt://logstash/config/syslog_celery.conf
    - mode: 644
    - template: jinja
    - require:
      - pkg: logstash