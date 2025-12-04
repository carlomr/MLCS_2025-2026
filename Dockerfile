FROM ghcr.io/jorgensd/dolfinx-tutorial:v0.9.1

# create user with a home directory
ARG NB_USER=joyvan
ARG NB_UID=1000
RUN id -nu ${NB_UID} && userdel --force $(id -nu ${NB_UID}) || true; \
    useradd -m ${NB_USER} -u ${NB_UID}
ENV HOME /home/${NB_USER}

# Copy home directory for usage in binder
WORKDIR ${HOME}

COPY requirements.txt ${HOME}/

RUN pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

COPY --chown=${NB_UID} . ${HOME}

USER ${NB_USER}
ENTRYPOINT []

