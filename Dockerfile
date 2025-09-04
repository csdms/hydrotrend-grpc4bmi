# A grpc4bmi server for the `Hydrotrend` model.
FROM csdms/grpc4bmi:0.3.0

LABEL org.opencontainers.image.authors="Mark Piper <mark.piper@colorado.edu>"
LABEL org.opencontainers.image.source="https://github.com/csdms/hydrotrend-grpc4bmi"

RUN git clone --branch v3.1.4 --depth 1 https://github.com/csdms-contrib/hydrotrend /opt/hydrotrend
WORKDIR /opt/hydrotrend/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    ctest -V && \
    make install && \
    make clean

COPY server /opt/hydrotrend-grpc4bmi-server
WORKDIR /opt/hydrotrend-grpc4bmi-server/_build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=${CONDA_DIR} && \
    make && \
    make install && \
    make clean

WORKDIR /opt

ENTRYPOINT ["/opt/conda/bin/hydrotrend-grpc4bmi-server"]
EXPOSE 55555
