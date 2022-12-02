FROM python:3.9

ENV VIRTUAL_ENV=/venv
ENV XAPIAN_VERSION=1.4.20

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    tesseract-ocr \
    tesseract-ocr-deu \
    imagemagick \
    gcc \
    && python -m venv /venv

ENV PATH="/venv/bin:$PATH"

WORKDIR /tmp/

RUN pip install sphinx \
    ## Compile & Install Xapian
    && mkdir -p /tmp/src\
    # build xapian-core
    && curl -SL https://oligarchy.co.uk/xapian/${XAPIAN_VERSION}/xapian-core-${XAPIAN_VERSION}.tar.xz \
    | tar -xJC /tmp/src \
    && /tmp/src/xapian-core-${XAPIAN_VERSION}/configure --prefix=/venv \
    && make \
    && make install \
    # build xapian-bindings
    && curl -SL http://oligarchy.co.uk/xapian/${XAPIAN_VERSION}/xapian-bindings-${XAPIAN_VERSION}.tar.xz \
    | tar -xJC /tmp/src \
    && /tmp/src/xapian-bindings-${XAPIAN_VERSION}/configure --prefix=/venv --with-python3 XAPIAN_CONFIG=/venv/bin/xapian-config \
    && make \
    && make install \
    # cleanup
    && rm -rf /tmp \
    # verify
    && python3 -c "import xapian; print(xapian.__version__)"
