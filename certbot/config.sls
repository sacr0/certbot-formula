# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "certbot/map.jinja" import certbot with context %}

include:
  - certbot.install

certbot-config:
  file.managed:
    - name: /etc/letsencrypt/cli.ini
    - makedirs: true
    - contents_pillar: certbot:config
