# CRON R GIT

Package using cron to run an R script and push results to a remote git repo

### CONFIG

server config:

- git clone repository
- add cron job (for 8am for example) using:
- crontab -e (from shell, then add the following line, save and exit)
- 0 8 * * * /path/to/file/cron_run.sh
- ensure that your rsa token will be accessible (no password etc) to be used by the cron job (if not, call with "ssh-agent bash -c" and reference the ssh key desired; ssh-keygen -t rsa -C "example.gmail.com" -b 4096)
- chmod +x cron_run.sh
- if necessary, create a ~/.ssh/config file and insert the line: UserKnownHostsFile ~/.ssh/known_hosts
