FROM httpd

RUN apt-get update

ADD https://github.com/saikumarKothada/website.git /usr/local/apache2/htdocs
