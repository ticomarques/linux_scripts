#!/bin/zsh
SERVICES=("apache2" "mysql")
EMAIL="admin@example.com"

for SERVICE in "${SERVICES[@]}"; do
  if ! systemctl is-active --quiet $SERVICE; then
    systemctl start $SERVICE
    echo "$SERVICE was down and has been restarted on $HOSTNAME" | mail -s "Service Restart Alert" $EMAIL
  fi
done
