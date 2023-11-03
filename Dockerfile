# ---- Base ----
FROM python:alpine AS base

#
# ---- Dependencies ----
FROM base AS dependencies
# install dependencies
COPY requirements.txt .
RUN pip install --user -r requirements.txt

#
# ---- Release ----
FROM base AS release
# copy installed dependencies and project source file(s)
WORKDIR /opt
COPY --from=dependencies /root/.local /root/.local
COPY cloudflare-ddns.py /opt/
CMD ["python", "-u", "/opt/cloudflare-ddns.py", "--repeat"]
