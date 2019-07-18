FROM ubuntu:bionic

# Install Essentials
RUN apt-get update -y && \
         apt-get upgrade -y && \
         apt-get install -y software-properties-common && \
         apt-add-repository -y ppa:openjdk-r/ppa && \
         apt-get update -y && \
         rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

# Install Packages
RUN apt-get -qq update -y && \
        apt-get -q install -y \
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            # Add new packages to install here:
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            wget \
            openjdk-8-jdk \
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - -
            && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*
        
RUN wget -q http://archive.apache.org/dist/karaf/4.2.3/apache-karaf-4.2.3.tar.gz -O /apache-karaf-4.2.3.tar.gz && \
    tar -xf /apache-karaf-4.2.3.tar.gz -C / && \
    rm /apache-karaf-4.2.3.tar.gz
    
COPY *.cfg /apache-karaf-4.2.3/etc/

CMD ["/apache-karaf-4.2.3/bin/karaf"]