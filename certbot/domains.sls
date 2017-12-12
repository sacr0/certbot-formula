# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "certbot/map.jinja" import certbot with context %}

include:
  - certbot.config

{% for setname, domainlist in salt['pillar.get']('certbot:domainsets').iteritems() %}

create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}:
  cmd.run:
    - name: certbot --nginx certonly -n -d {{ domainlist|join(' -d ') }}
    - creates: /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain.pem
    - require:
      - file: certbot-config

# domainlist[0] represents the "CommonName", and the rest
# represent SubjectAlternativeNames
#create-fullchain-privkey-pem-for-{{ domainlist[0] }}:
#  cmd.run:
#    - name: |
#        cat /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain.pem \
#            /etc/letsencrypt/live/{{ domainlist[0] }}/privkey.pem \
#            > /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain-privkey.pem && \
#        chmod 600 /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain-privkey.pem
#    - creates: /etc/letsencrypt/live/{{ domainlist[0] }}/fullchain-privkey.pem
#    - require:
#      - cmd: create-initial-cert-{{ setname }}-{{ domainlist | join('+') }}

{% endfor %}

certbot-crontab-autorenew:
  cron.present:
    - name: certbot renew
    - month: '*'
    - minute: random
    - hour: random
    - dayweek: '*'
    - identifier: letsencrypt-autorenew