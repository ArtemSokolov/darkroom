FROM gitpod/workspace-full-vnc:latest

RUN sudo apt-get update && \
    sudo apt-get install qtbase5-dev qtchooser qt5-qmake qtbase5-dev-tools && \
    sudo rm -rf /var/lib/apt/lists/*

RUN python -m pip install "napari[all]"
