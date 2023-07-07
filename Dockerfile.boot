# Base image
FROM debian

# Environment
ENV MPS_USER=mps
ENV MPS_PASS=mps
ENV MPS_PATH=/opt/mps
ENV MPS_TOOLS=/opt/mps/tools
ENV DEBIAN_FRONTEND=noninteractive

# Initial clone
RUN apt --yes update && apt --yes upgrade
RUN apt --yes install git
RUN git clone https://github.com/odem/mps.git $MPS_PATH

# Bootstrap user
RUN cd $MPS_PATH && ./bootstrap.bash -u $MPS_USER -p $MPS_USER
USER ${MPS_USER}
WORKDIR /home/${MPS_USER}

# Entrypoint
ENTRYPOINT ["tail"]
CMD ["-f","/dev/null"]
