FROM fedora:32
USER root
RUN yum -y install krb5-workstation python3.6 python3-pip krb5-devel openssl-devel cronie \
	mariadb-connector-c-devel gcc python3-devel
WORKDIR /opt/app-root/src
RUN echo "$(echo '00 06 * * * sh ./cron_jobs/data_import.sh' ; crontab -l)" | crontab -
COPY requirements.txt ./
RUN pip3 install -r requirements.txt
COPY . .
EXPOSE 8080
ENV RUN_ENV=development
CMD ["./start-cmd.sh"]
