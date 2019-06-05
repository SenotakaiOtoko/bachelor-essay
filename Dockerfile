FROM ubuntu:18.04
LABEL maintainer="Rybakov <senotakaiOtoko@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV DIR /master-thesis

RUN mkdir $DIR
RUN echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections
RUN apt update && \
    apt install -y wget \
        git \
        make \
        apt-transport-https \
        unzip && \
    apt install -y texlive-base \
        texlive-latex-extra \
        texlive-xetex \
        texlive-lang-cyrillic \
        texlive-fonts-extra \
        texlive-science \
        texlive-latex-recommended \
        latexmk

# Times New Roman and other fonts
RUN apt install -y --reinstall ttf-mscorefonts-installer && \
    wget -O /usr/share/fonts/xits-math.otf https://github.com/khaledhosny/xits-math/raw/master/XITSMath-Regular.otf && \
    wget https://github.com/SenotakaiOtoko/PTSans/archive/PTSans.zip && \
    wget https://github.com/SenotakaiOtoko/PTMono/archive/PTMono.zip && \
    wget https://github.com/SenotakaiOtoko/Anonymous-Pro/archive/Anonymous-Pro.zip && \
    unzip PTSans.zip -d /usr/share/fonts/ && \
    unzip PTMono.zip -d /usr/share/fonts/ && \
    unzip Anonymous-Pro.zip -d /usr/share/fonts/ && \
    rm -f PTSans.zip PTMono.zip Anonymous-Pro.zip && \
    fc-cache -f -v

VOLUME $DIR
WORKDIR $DIR
