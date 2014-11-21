{%- from "swift/map.jinja" import swift with context %}
{%- from "swift/map.jinja" import swift_account_config with context %}

include:
  - .rsync

store-server:
  pkg.installed:
    - refresh: False
    - pkgs: {{ swift.store_pkgs }}
  service.running:
    - names: {{ swift.store_services }}
    - enable: True
    - require:
      - file: /etc/swift/account-server.conf
      - file: /etc/swift/container-server.conf
      - file: /etc/swift/object-server.conf
    - watch:
      - file: /etc/swift/account-server.conf
      - file: /etc/swift/container-server.conf
      - file: /etc/swift/object-server.conf

{% for conf in swift.store_confs %}
/etc/swift/{{ conf }}:
  file.managed:
    - source: salt://swift/files/{{ conf }}
    - user: swift
    - group: swift
    - mode: 644
    - template: jinja
    - makedirs: True
{% endfor %}

{{ swift_account_config.DEFAULT.devices }}:
  file.directory:
    - user: swift
    - group: swift
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

{{ swift_account_config.DEFAULT.cache_dir }}:
  file.directory:
    - user: swift
    - group: swift
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
