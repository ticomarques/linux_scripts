Useful scripts for linux (DevOps, SysOps, SecOps)


Execute 

```
sudo chmod +x /opt/scripts/system-health.sh
```


Before you let Cron handle the job, it’s a good idea to run the script manually to make sure everything works as expected.

```
sudo /opt/scripts/system-health.sh
```


You should see a well-structured report with details about disk usage, CPU load, memory stats, failed services, and more.

```
cat /var/log/system-health-$(date +%F).log
```


```
sudo crontab -e
```

At the bottom of the file, add the following line:
```
0 7 * * * /opt/scripts/system-health.sh
```


If you want to save the output or errors of the cron job, you can modify the line like this:
```
0 7 * * * /opt/scripts/system-health.sh >> /var/log/system-health-cron.log 2>&1
```


# Set Up Mail (Optional but Useful)
```
sudo apt install mailutils -y
```


# Displaying System Health in the MOTD (Message of the Day)

One reader had a great idea of displaying a brief version of this health check as a MOTD when logging into your server, which is a smart way to instantly see the system’s health status without 
running any commands

Create a lightweight MOTD script and save this script as /etc/update-motd.d/99-system-health.

```

#!/bin/bash
# Lightweight System Health MOTD
# Author: Ravi Saive (Tecmint)

echo "==== 🩺 System Health: $(hostname) ===="
echo "🕒 Uptime: $(uptime -p)"
echo "💽 Disk: $(df -h / | awk 'NR==2 {print $5 " used on " $6}')"
echo "📊 CPU Load: $(uptime | awk -F'load average:' '{print $2}' | sed 's/^ //')"
echo "🧠 Memory: $(free -m | awk '/Mem:/ {print $3 "MB used / " $2 "MB total"}')"
FAILED=$(systemctl --failed --no-legend | wc -l)
echo "🚨 Failed Services: $FAILED"
echo "====================================="

```


Make it executable:

```
sudo chmod +x /etc/update-motd.d/99-system-health
```


This method works on Ubuntu and Debian-based systems where dynamic MOTD is enabled by default. For other distributions, you can include this script in .bashrc or .bash_profile.

Now every time you SSH into your server, you’ll get a quick overview of your system’s health – no extra steps needed!




