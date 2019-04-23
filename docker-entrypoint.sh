#!/bin/bash
set -e

if [ -z "$@" ]; then

	if [ ! -f /etc/tine20/config.inc.php ]; then
		cp /opt/tine20/config.inc.php_dist /etc/tine20/config.inc.php
	fi

	if [ "$TINE20_DB_HOST" ]; then
		sed -i "s/ENTER DATABASE HOSTNAME/$TINE20_DB_HOST/" /etc/tine20/config.inc.php
	else
		sed -i "s/ENTER DATABASE HOSTNAME/mysql-server/" /etc/tine20/config.inc.php
	fi

	if [ "$TINE20_DB_NAME" ]; then
		sed -i "s/ENTER DATABASE NAME/$TINE20_DB_NAME/" /etc/tine20/config.inc.php
	else
		sed -i "s/ENTER DATABASE NAME/tine20/" /etc/tine20/config.inc.php
	fi

	if [ "$TINE20_DB_USER" ]; then
		sed -i "s/ENTER DATABASE USERNAME/$TINE20_DB_USER/" /etc/tine20/config.inc.php
	else
		sed -i "s/ENTER DATABASE USERNAME/tine20/" /etc/tine20/config.inc.php
	fi

	if [ "$TINE20_DB_PASS" ]; then
		sed -i "s/ENTER DATABASE PASSWORD/$TINE20_DB_PASS/" /etc/tine20/config.inc.php
	else
		sed -i "s/ENTER DATABASE PASSWORD//" /etc/tine20/config.inc.php
	fi

	if [ "$TINE20_SETUP_USER" ]; then
		sed -i "s/SETUP USERNAME/$TINE20_SETUP_USER/" /etc/tine20/config.inc.php
	else
		sed -i "s/SETUP USERNAME/tine20setup/" /etc/tine20/config.inc.php
	fi

	if [ "$TINE20_SETUP_PASS" ]; then
		sed -i "s/SETUP PASSWORD/$TINE20_SETUP_PASS/" /etc/tine20/config.inc.php
	else
		sed -i "s/SETUP PASSWORD//" /etc/tine20/config.inc.php
	fi
	/usr/sbin/cron
	/usr/sbin/apache2ctl -DFOREGROUND
fi

exec "$@"
