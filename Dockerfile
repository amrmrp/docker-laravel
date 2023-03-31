FROM php:8.1-apache

COPY . /var/www/html/

# update container
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install vim nano

# install composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN echo $HASH
RUN php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer 

# composer install 
RUN if [ -f composer.json ] ; then composer install ; else echo “composer.json File does not exist”; fi

#supervisor run serve
RUN apt-get install supervisor -y
RUN cd /etc/supervisor/conf.d && echo -e "[program:laravel-worker] \nprocess_name=%(program_name)s_%(process_num)02d \ncommand=php /var/www/html/artisan  serve --host 0.0.0.0 --port 8000 \nautostart=true  \nautorestart=true \nuser=root \nnumprocs=1 \nredirect_stderr=true \nstdout_logfile=/var/www/html/worker.log" > laravel-worker.conf
RUN cd /etc/supervisor/conf.d && sed -i 's/-e//' laravel-worker.conf && sed -i 's/^[ \t]*//' laravel-worker.conf
RUN service supervisor start 
#RUN supervisorctl reread
#RUN supervisorctl update
#RUN supervisorctl start laravel-worker:*


# run nohup 
#RUN if [ -f artisan ] ; then cd public && nohup nice -n 19 php -S 0.0.0.0:8000 ; else echo “not exist”; fi
