{%- from "swift/map.jinja" import swift with context %}

rsync:
  pkg.installed:
    - refresh: False
    - name: {{ swift.rsync_pkg }}
  service.running:
    - name: {{ swift.rsync_service }}
    - enable: True
    - require:
      - pkg: rsync
      - file: /etc/rsyncd.conf
    - watch:
      - file: /etc/rsyncd.conf

sed -i 's/RSYNC_ENABLE=false/RSYNC_ENABLE=true/' /etc/default/rsync:
  cmd.run

/etc/rsyncd.conf:
  file.managed:
    - source: salt://swift/files/rsyncd.conf
    - template: jinja
