include:
  - elasticsearch

nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/nginx/sites-available/default
    - watch:
      - file: kopf_external_settings

apache2-utils:
  pkg.installed

htpassword_user:
  webutil.user_exists:
    - name: {{ salt['pillar.get']('nginx:htpasswd_username') }}
    - password: {{ salt['pillar.get']('nginx:htpasswd_password') }}
    - htpasswd_file: /etc/nginx/htpasswd
    - options: d
    - force: false
    - require:
      - pkg: nginx
      - pkg: apache2-utils

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx/config/sites_available_default
    - template: jinja
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: nginx