FROM randomknowledge/docker-pyenv-tox:latest

MAINTAINER Florian Finke <florian@finke.email>

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties winbind wget
RUN add-apt-repository ppa:wine/wine-builds
RUN apt-get update
RUN apt-get install -y --install-recommends winehq-staging mono-devel
RUN mkdir -p /home/wine/.cache/wine
RUN wget https://dl.winehq.org/wine/wine-mono/4.6.4/wine-mono-4.6.4.msi -O /home/wine/.cache/wine/wine-mono-4.6.4.msi
RUN wget https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86.msi -O /home/wine/.cache/wine/wine_gecko-2.47-x86.msi
RUN wget https://dl.winehq.org/wine/wine-gecko/2.47/wine_gecko-2.47-x86_64.msi -O /home/wine/.cache/wine/wine_gecko-2.47-x86_64.msi
RUN groupadd -g 1010 wine
RUN useradd -s /bin/bash -u 1010 -g 1010 wine
RUN chown -R wine:wine /home/wine
RUN npm install -g electron-packager

ADD ./electron-cache /tmp/electron-cache
