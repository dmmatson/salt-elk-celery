include:
  - elasticsearch

/etc/init.d/kibana4:
  file.managed:
    - source: salt://kibana/init-scripts/kibana4
    - template: jinja
    - user: root
    - group: root
    - mode: 755

kibana4:
  archive.extracted:
    - name: /opt/
    - source: https://download.elastic.co/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz
    - source_hash: md5=3a9bba5bb5e883851904fde9b79c291f
    - tar_options: v
    - archive_format: tar
    - if_missing: /opt/kibana-4.1.1-linux-x64/
  service:
    - running
    - require:
      - file: /etc/init.d/kibana4
    - watch:
      - file: /etc/init.d/kibana4
      - file: /opt/kibana-4.1.1-linux-x64/config/kibana.yml

/opt/kibana-4.1.1-linux-x64/config/kibana.yml:
  file.managed:
    - source: salt://kibana/config/kibana.yml
    - template: jinja
    - user: root
    - group: root
    - mode: 755
    - require:
      - archive: kibana4