# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "certbot/map.jinja" import certbot with context %}

certbot:
  pkg.installed:
    - name: {{ certbot.pkg }}

