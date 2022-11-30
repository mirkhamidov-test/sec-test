#!/bin/bash
set -e

# Display PHP error's or not
if [[ -f /usr/etc/php.ini ]] && [[ "$ERRORS" != "1" ]] ; then
  sed -i -e "s/error_reporting =.*=/error_reporting = E_ALL/g" /usr/etc/php.ini
  sed -i -e "s/display_errors =.*/display_errors = stdout/g" /usr/etc/php.ini
fi

# Disable opcache?
if [[ -f /etc/php.d/zend-opcache.ini ]] && [[ -v NO_OPCACHE ]] ; then
    sed -i -e "s/zend_extension=opcache.so/;zend_extension=opcache.so/g" /etc/php.d/zend-opcache.ini
fi

# Install dependencies
$(which composer) install --no-interaction

server() {
  exec php-fpm -c /usr/etc
}


help() {
  echo "Docker container."
  echo ""
  echo "Usage:"
  echo ""
  echo "server -- start app backend"
  echo ""
}

case "$1" in
  server)
    shift
    server
    ;;
  help)
    shift
    help
    ;;
  *)
    exec "$@"
    ;;
esac
