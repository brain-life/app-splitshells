FROM brainlife/mcr:centos6-r2016a

MAINTAINER Lindsey Kitchell <kitchell@indiana.edu>

#RUN yum update 

ADD /msa /msa

#we want all output to go here (config.json should also go here)
WORKDIR /output

ENTRYPOINT ["/msa/main"] 