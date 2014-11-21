{%- from "swift/map.jinja" import swift_account_config with context %}

{{ swift_account_config.devices }}:
  file.directory:
    - user: swift
    - group: swift
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode

{{ swift_account_config.cache_dir }}:
  file.directory:
    - user: swift
    - group: swift
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group
      - mode
