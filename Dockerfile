FROM ubuntu@sha256:aa772c98400ef833586d1d517d3e8de670f7e712bf581ce6053165081773259d
SHELL ["/bin/bash", "-c"]

ENV CONTAINER_NAME="cpp-dev-ubuntu"
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PATH="/usr/local/bin:$PATH"


# version numbers
ARG gtest_version="release-1.11.0"

# install gcc, g++, git, valgrind, cmake, doxygen
RUN apt update && apt install -y 'g++' 'gcc' 'git' 'valgrind' 'cmake' 'doxygen' 

# install boost
RUN apt upgrade -y && apt update && apt install -y libboost-all-dev

# install GoogleTest
## clone
RUN git clone --branch ${gtest_version} https://github.com/google/googletest.git && \
## compile and install in /usr/local
	cd googletest/ && \
	cmake . && \
	make install && \
## clean
	cd .. && \
	rm -rf googletest/
# clean
RUN apt clean && apt-get clean
