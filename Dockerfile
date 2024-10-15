FROM python:3.11-slim
COPY . .
COPY tidal.conf /root/.tidal-dl.json
ENV PYTHONPATH=/tidal_dl/
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install pipenv && \
  apt-get update && \
  apt-get install -y --no-install-recommends gcc python3-dev libssl-dev && \
pip3 install --no-cache-dir psutil && pip3 install --no-cache-dir -r requirements.txt && \
pip3 install --no-cache-dir -e AIGPY/ && \
pip3 install --no-cache-dir -e . &&  apt-get remove -y gcc python3-dev libssl-dev && \
  apt-get autoremove -y && \
  pip uninstall pipenv -y
CMD tidal-dl
