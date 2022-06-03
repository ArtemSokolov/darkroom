FROM gitpod/workspace-full-vnc:latest

RUN sudo apt-get update && \
    sudo apt-get install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools && \
    sudo rm -rf /var/lib/apt/lists/*

RUN python -m pip install "napari[all]"

RUN python -m pip install synapseclient

RUN cd /workspace && curl -o bftools.zip \
        https://downloads.openmicroscopy.org/bio-formats/6.10.0/artifacts/bftools.zip && \
        unzip bftools.zip && rm bftools.zip
