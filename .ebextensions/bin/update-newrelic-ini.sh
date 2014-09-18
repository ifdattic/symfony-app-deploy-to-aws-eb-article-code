#!/bin/bash

sed -i -e 's/newrelic.license.*/newrelic.license = '"$NEW_RELIC_LICENSE_KEY"'/' /etc/php-5.5.d/newrelic.ini
sed -i -e 's/newrelic.appname.*/newrelic.appname = "'"$SYMFONY__ENV__NEW_RELIC__APPLICATION_NAME"'"/' /etc/php-5.5.d/newrelic.ini
