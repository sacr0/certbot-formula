# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "certbot/map.jinja" import certbot with context %}

include:
  - certbot.config

{% for setname, domainlist in salt['pillar.get']('certbot:domainsets', {}).iteritems() %}

create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}:
  cmd.run:
    - name: certbot --nginx certonly -n -d {{ domainlist|join(' -d ') }}
    - creates: /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain.pem
    - require:
      - file: certbot-config

{% endfor %}

