# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "certbot/map.jinja" import certbot with context %}

certbot:
  pkg.installed:
    - name: {{ certbot.pkg }}

#certbot-client-git:
#  git.latest:
#    - name: https://github.com/certbot/certbot
#    - target: {{ certbot.cli_install_dir }}
#    - force_reset: True
