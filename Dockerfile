FROM ubuntu:19.04 AS builder

RUN apt-get update -yqq \
    && apt-get install -y --no-install-recommends \
       binutils-dev \
       build-essential \
       ca-certificates \
       cmake \
       git \
       libcurl4-openssl-dev \
       libdw-dev \
       libiberty-dev \
       python3 \
       zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# kcovのビルド
RUN git clone --depth 1 https://github.com/SimonKagstrom/kcov \
    && cd kcov \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install \
    && kcov --version

FROM unkontributors/super_unko/ci_sh_default:latest AS runtime

COPY --from=builder /usr/local/bin/kcov /usr/local/bin/kcov

RUN apt-get update -yqq \
    && apt-get install -y --no-install-recommends \
       binutils-dev \
       libcurl4-openssl-dev \
       libdw-dev \
       libiberty-dev \
       zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# kcovのrootユーザだとカバレッジがとれないバグの回避のため
RUN useradd -d /home/kcov kcov
USER kcov

ENTRYPOINT ["kcov"]
