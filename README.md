# kubernetes-ubuntu
- cron-file formant
```
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

* * * * * root echo test > /tmp/test
```
### ssh login
- need modify ubuntu/conf/authorized_keys to add public key
