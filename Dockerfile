
FROM ubuntu:xenial

RUN : "base packages" && \
  apt-get clean && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    build-essential   \
    bzip2             \
    curl              \
    git               \
    tar               \
    wget
              
RUN : "python" && \
  apt-get install -y --no-install-recommends \
    python3             \
    python3-dev         \
    python3-pyqt5       \
    python3-pip         \
    python3-poppler-qt5

RUN : "useful for pyinstaller" && \
  apt-get install -y --no-install-recommends \
    upx

WORKDIR /opt/work

COPY krop.patch /tmp
COPY pypdf4.patch /tmp

RUN \
  pip3 install --upgrade pip                          && \
  pip install --upgrade pyinstaller                   && \
  git clone https://github.com/claird/PyPDF4.git      && \
  (cd PyPDF4                                  && \
    git checkout tags/v1.27.0 -b tmp-v1.27.0  && \
    patch -p0 < /tmp/pypdf4.patch             && \
    python3 setup.py install)                 && \
  git clone https://github.com/arminstraub/krop.git   && \
  (cd krop && patch -p0 < /tmp/krop.patch)

WORKDIR /opt/work/krop

RUN \
  pyinstaller --onefile bin/krop

COPY control krop-0.5.1/DEBIAN/

RUN : "build .deb file" && \
  bash -c "mkdir -p krop-0.5.1/{DEBIAN,usr/bin,usr/share/man/man1,usr/share/doc/krop,usr/share/metainfo,usr/share/applications}" && \
  cp dist/krop        krop-0.5.1/usr/bin                  && \
  cp krop.1           krop-0.5.1/usr/share/man/man1       && \
  cp krop.appdata.xml krop-0.5.1/usr/share/metainfo       && \
  cp krop.desktop     krop-0.5.1/usr/share/applications   && \
  dpkg -b ./krop-0.5.1


