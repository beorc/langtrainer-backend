FROM httplab/ruby-dev-app:2.3

RUN cd /tmp && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
    tar xvjf phantomjs-2.1.1-linux-x86_64.tar.bz2 && mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/ && \
    chmod +x /usr/local/bin/phantomjs

USER $USER

EXPOSE 3000/tcp

CMD rm -f tmp/pids/server.pid && \
    bundle exec rails s -b 0.0.0.0
