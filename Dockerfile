FROM python:3.10-slim-bookworm

# new user: littlemilk
ARG USER=littlemilk
RUN apt-get update && \
    adduser --shell /bin/bash ${USER}
# copy streamlit src
COPY BackgroundRemoval /home/${USER}/bg_remove

# add user to /bg_remove folder's permission
RUN chown -R ${USER} /home/${USER}/bg_remove

# switch user
USER ${USER}
WORKDIR /home/${USER}/bg_remove

# install package
RUN pip install -r requirements.txt

EXPOSE 8501
ENV PATH="/home/${USER}/.local/bin:$PATH"

# run streamlit
# ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["streamlit", "run", "bg_remove.py"]