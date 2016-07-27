FROM ubuntu:14.04
ENV DJANGO_PATH=/opt/src/src/klee_web/ \
    PROJECT_PATH=/opt/src/

RUN apt-get update
RUN apt-get install -y curl wget
RUN /bin/bash -c 'curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -'
RUN /bin/bash -c 'wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -'
ADD pgdg.list /etc/apt/sources.list.d/pgdg.list

RUN apt-get update
RUN apt-get install -y \
    software-properties-common \
    nodejs \
    build-essential \
    libpcre3 \
    libpcre3-dev \
    python-dev \
    python-pip \
    postgresql-9.5 \
    postgresql-contrib-9.5 \
    libpq-dev \
    python-psycopg2

RUN npm install -g grunt-cli bower
RUN add-apt-repository ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y \
  ruby2.3 \
  ruby2.3-dev

RUN update-alternatives --set ruby /usr/bin/ruby2.3
RUn gem install sass

# Set up package and requirements
# TODO: Maybe switch to git clone for production
COPY src ${PROJECT_PATH}
# Satisfy requirements for JS and compile everything
RUN cd /opt/src && \
    npm install && \
    bower install --allow-root && \
    grunt

COPY pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
COPY postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
RUN pip install -r ${DJANGO_PATH}/requirements.txt
COPY uwsgi.ini /etc/uwsgi.ini
COPY python_runner.sh ${PROJECT_PATH}/python_runner.sh
COPY klee-web-environment.sh /etc/profile.d/klee-web-environment.sh
COPY run_uwsgi.sh /usr/local/bin/run_uwsgi.sh
ENTRYPOINT ["/opt/src/python_runner.sh", "/usr/local/bin/run_uwsgi.sh"]
