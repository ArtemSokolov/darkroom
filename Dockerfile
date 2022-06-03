FROM gitpod/workspace-full-vnc:latest

# Qt5 graphics libraries for napari
RUN sudo apt-get update && \
    sudo apt-get install -y qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools && \
    sudo rm -rf /var/lib/apt/lists/*

# Napari image viewer
RUN python -m pip install "napari[all]"

# Client for synapse.org
RUN python -m pip install synapseclient

# Additional libraries for image processing not covered by napari
RUN python -m pip install zarr

# Tools for working with bioformats-compatible images
RUN cd /workspace && curl -o bftools.zip \
        https://downloads.openmicroscopy.org/bio-formats/6.10.0/artifacts/bftools.zip && \
        unzip bftools.zip && rm bftools.zip
