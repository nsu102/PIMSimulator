FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    scons \
    libgtest-dev \
    cmake \
    && cmake -S /usr/src/googletest -B /tmp/gtest-build \
    && cmake --build /tmp/gtest-build --target install \
    && rm -rf /var/lib/apt/lists/* /tmp/gtest-build

WORKDIR /work
COPY . .

RUN scons

CMD ["./sim", "--gtest_list_tests"]
