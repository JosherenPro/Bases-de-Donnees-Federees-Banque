# Utilise l'image officielle PostgreSQL 16 (Debian-based)
FROM postgres:16

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-16-mysql-fdw \
    freetds-dev \
    freetds-bin \
    libsybdb5 \
    gcc \
    make \
    postgresql-server-dev-16 \
    git \
    ca-certificates \
    netcat-openbsd \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Compilation de tds_fdw
WORKDIR /tmp
RUN git clone https://github.com/tds-fdw/tds_fdw.git && \
    cd tds_fdw && \
    make USE_PGXS=1 && \
    make USE_PGXS=1 install && \
    cd /tmp && \
    rm -rf tds_fdw

# Configuration FreeTDS pour SQL Server
RUN echo "[mssql-compta]\n\
    host = mssql-compta\n\
    port = 1433\n\
    tds version = 7.4\n\
    client charset = UTF-8\n" >> /etc/freetds/freetds.conf

# Nettoyage des paquets de compilation (optionnel)
RUN apt-get remove -y gcc make postgresql-server-dev-16 git && \
    apt-get autoremove -y

USER postgres