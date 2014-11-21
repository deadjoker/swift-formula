{%- from "swift/map.jinja" import swift with context %}

swift-client:
  pkg.installed:
    - refresh: False
    - name: {{ swift.client_pkg }}
