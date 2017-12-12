===================
certbot-formula
===================

Creates certificates and manages renewal using the letsencrypt service.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``certbot``
---------------

Installs and configures the letsencrypt certbot client, creates the requested certificates and installs renewal cron job.
This is a shortcut for certbot.install certbot.config and certbot.domains .

``certbot.install``
-----------

Only installs the letsencrypt/certbot client. 

``certbot.config``
----------

Manages /etc/letsencrypt/cli.ini config file.

``certbot.domains``
-----------
Creates a certificate with the domains in each domain set (certbot:domainsets in pillar). Letsencrypt uses a relatively short validity of 90 days.
Therefore, a cron job for automatic renewal every 60 days is installed for each domain set as well.
