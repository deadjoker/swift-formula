{%- from "swift/map.jinja" import swift with context %}

include:
  - .keystone

{{ swift.name }}:
  pkg.installed:
    - refresh: False
    - name: {{ swift.proxy_pkg }}
  service.running:
    - name: {{ swift.proxy_service }}
    - enable: True
    - require:
      - pkg: {{ swift.name }}
      - file: /etc/swift/swift.conf
    - watch:
      - file: /etc/swift/swift.conf

{% for conf in swift.proxy_confs %}
/etc/swift/{{ conf }}:
  file.managed:
    - source: salt://swift/files/{{ conf }}
    - user: swift
    - group: swift
    - template: jinja
    - mode: 644
    - makedirs: True
{% endfor %}
