# CRON R GIT

Package using cron to run an R script and push results to a remote git repo

### CONFIG

server config:

- clone repository
- add cron job (for 8am ET...assumes that sms requests are generated 1/day in the afternoon by Redcap) using:
- crontab -e 0 8 * * * /path/to/file/cron_run.sh
- ensure that your rsa token will be accessible (no password etc) to be used by the cron job (if not, call with "ssh-agent bash -c" and reference the ssh key desired; ssh-keygen -t rsa -C "example.gmail.com" -b 4096)
- chmod +x cron_run.sh
- if necessary, create a ~/.ssh/config file and insert the line: UserKnownHostsFile ~/.ssh/known_hosts
