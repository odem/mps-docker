# Base image
FROM mpsimg.dsk

# # Desktop installation
# RUN cd $MPS_PATH \
#     && sudo git pull \
#     && ./desktop.bash -u $MPS_USER

# Tigervnc
RUN sudo mkdir -p $MPS_TOOLS/tigervnc
COPY tiger-vnc-password.txt $MPS_TOOLS/tigervnc/tiger-vnc-password.txt
EXPOSE 5901

# Entrypoint
COPY entrypoint.bash $MPS_TOOLS/entrypoint.bash
RUN sudo chmod a+rx $MPS_TOOLS/entrypoint.bash
#ENTRYPOINT tail -f /dev/null

ENTRYPOINT $MPS_TOOLS/entrypoint.bash

