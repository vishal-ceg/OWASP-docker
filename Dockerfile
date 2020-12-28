FROM java:8

RUN wget http://dl.bintray.com/jeremy-long/owasp/dependency-check-6.0.3-release.zip && unzip dependency-check-6.0.3-release.zip && mv dependency-check /usr/share/

RUN useradd -ms /bin/bash dockeruser && chown -R dockeruser:dockeruser /usr/share/dependency-check && mkdir /report && chown -R dockeruser:dockeruser /report
USER dockeruser

VOLUME ["/src", "/usr/share/dependency-check/data","/report"]

WORKDIR /src

ENTRYPOINT ["/usr/share/dependency-check/bin/dependency-check.sh","--scan","/src","--format","JSON","--out","/report"]
CMD ["--project", "OWASP Dependecy Check Project"]