FROM python:3.9 as build

ENV VIRTUAL_ENV=/venv
ENV XAPIAN_VERSION=1.4.20

RUN apt-get update;
RUN apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    tesseract-ocr \
    tesseract-ocr-deu \
    imagemagick \
    gcc

RUN python -m venv /venv

ENV PATH="/venv/bin:$PATH"

RUN pip install sphinx

# Compile & Install Xapian
ADD https://oligarchy.co.uk/xapian/${XAPIAN_VERSION}/xapian-core-${XAPIAN_VERSION}.tar.xz /tmp/
WORKDIR /tmp/
RUN tar Jxf /tmp/xapian-core-${XAPIAN_VERSION}.tar.xz
WORKDIR /tmp/xapian-core-${XAPIAN_VERSION}
RUN ./configure --prefix=/venv && make && make install

ADD http://oligarchy.co.uk/xapian/${XAPIAN_VERSION}/xapian-bindings-${XAPIAN_VERSION}.tar.xz /tmp/
WORKDIR /tmp/
RUN tar Jxf /tmp/xapian-bindings-${XAPIAN_VERSION}.tar.xz
WORKDIR /tmp/xapian-bindings-${XAPIAN_VERSION}
RUN ./configure --prefix=/venv --with-python3 XAPIAN_CONFIG=/venv/bin/xapian-config && make && make install
RUN python3 -c "import xapian; print(xapian.__version__)"
