FROM python:3.9

ENV VIRTUAL_ENV=/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV PYTHONPATH="$PYTHONPATH:/usr/lib/python3/dist-packages/"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-xapian \
    tesseract-ocr \
    tesseract-ocr-deu \
    imagemagick \
    gcc \
    && rm -rf /var/lib/apt/lists/* \
    && python -m venv /venv

ENV PATH="/venv/bin:$PATH"

WORKDIR /tmp/

RUN python3 -m venv "$VIRTUAL_ENV" \
    && python3 -c "import xapian; print(xapian.__version__)"
