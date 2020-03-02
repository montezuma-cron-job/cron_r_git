# CRON R GIT

Package using cron to run an R script and push results to a remote git repo

### CONFIG

server config:

- git clone repository (ussing ssh, not https because git actions will have to be automated)
- git clone git@github.com:montezuma-cron-job/cron_r_git.git
- crontab -e (from shell on computer that will remain web-connected, then add the following line)
- 0 8 * * * /path/to/file/cron_run.sh
- Create an ssh key if you need to: ssh-keygen -t rsa -C "example.gmail.com" -b 4096
- ensure that your rsa token will be accessible (no password etc) to be used by the cron job (if not, call with "ssh-agent bash -c" and reference the ssh key desired)
- chmod +x cron_run.sh
- if necessary, create a ~/.ssh/config file and insert the line: UserKnownHostsFile ~/.ssh/known_hosts
