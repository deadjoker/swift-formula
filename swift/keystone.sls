keystone_swift_user:
  keystone.user_present:
    - name: swift
    - password: {{ salt['pillar.get']('swift:keystone:password') }}
    - email: {{ salt['pillar.get']('swift:keystone:email') }}
    - tenant: service
    - enable: True
    - roles:
      - service:
        - admin

keystone_swift_service:
  keystone.service_present:
    - name: swift
    - service_type: object-store
    - description: Openstack Object Storage

keystone_swift_endpoint:
  keystone.endpoint_present:
    - name: swift
    - publicurl: http://{{ salt["pillar.get"]("swift:public_ip") }}:8080/v1/AUTH_%(tenant_id)s
    - internalurl: http://{{ salt["pillar.get"]("swift:internal_ip") }}:8080/v1/AUTH_%(tenant_id)s
    - adminurl: http://{{ salt["pillar.get"]("swift:admin_ip") }}:8080
    - region: regionOne
