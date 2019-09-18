###########################################################################
# From
From ubuntu:16.04
###########################################################################
# ARG app Version
###########################################################################
# ENV
###########################################################################
# ADD
ADD ubuntu/conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
###########################################################################
# RUN
RUN set -eux \
  echo "\n################## dash > bash ###################" \
  && mv /bin/sh /bin/sh.old && ln -s bash /bin/sh \
  && echo "\n################## apt update ###################" \
  && apt-get update  && apt-get install -y \
     sudo vim wget netcat dnsutils git curl unzip locales unzip rsync python \
     dnsutils jq openssh-client openssh-server python-pip netcat git cron supervisor \
  && echo "\n################## add root bashrc ###################" \
  && locale-gen zh_TW.UTF-8 && echo 'export LANGUAGE="zh_TW.UTF-8"' >> /root/.bashrc \
  && echo 'export LANG="zh_TW.UTF-8"' >> /root/.bashrc \
  && echo 'export LC_ALL="zh_TW.UTF-8"' >> /root/.bashrc && update-locale LANG=zh_TW.UTF-8 \
  && echo "\n################## ssh_config ###################" \
  && echo "Host *" >> /etc/ssh/ssh_config \
  && echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config \
  && echo "    UserKnownHostsFile /dev/null" >> /etc/ssh/ssh_config \
  && echo "\n################## clear apt cache ##################" \
  && rm -rf /var/lib/apt/lists/* && apt-get clean && apt-get autoremove \
  && echo "\n################## mkdir /var/run/sshd ##########" \
  && mkdir -p /var/run/sshd \
  && echo "\n################## sed /etc/sudoers ##########" \
  && sed -i 's|%sudo	ALL=(ALL:ALL) ALL|%sudo ALL=(ALL:ALL) NOPASSWD: ALL|' /etc/sudoers \
  && echo "\n################## sed /etc/ssh/sshd_config ##########" \
  && sed -i 's|#PasswordAuthentication yes|PasswordAuthentication no|' /etc/ssh/sshd_config
###########################################################################
# VOLUME
###########################################################################
# ENTRYPOINT
###########################################################################
# CMD
CMD ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
