FROM centos:7 as build

ADD ./IBMDominoCommunityServerforNonProduction10.0.1Linux.tar /domino

ADD ./domstart.sh /domino/.

RUN yum -y install perl which \
    && groupadd -g 1000 notes \
    && useradd -u 1000 -g notes -s /bin/bash -d /home/notes notes \
    && mkdir -p /local/notesdata \
    && chown notes:notes /local/notesdata \
    && cd /domino/linux64/DominoEval/; ./install -options "unix_response.dat" -silent \
    && cd /opt/ibm/domino/notes/latest/linux; mv ./tunekrnl ./disabled.tunekrnl \
    && rm -r /domino/linux64 \
    && tar -czvf /domino/notesdata.tar.gz /local/notesdata \
    && rm -r /local/notesdata

FROM scratch
COPY --from=build / /

CMD [ "/usr/sbin/init" ]
