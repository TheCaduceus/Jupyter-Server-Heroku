FROM kalilinux/kali-rolling
EXPOSE 8080

RUN apt update -y
RUN apt install curl -y
RUN apt install unrar -y
RUN apt install wget -y
RUN apt install jupyter -y
RUN apt install unzip -y
RUN apt install pip -y
RUN apt install unzip -y
RUN pip install jupyter_http_over_ws
RUN jupyter serverextension enable --py jupyter_http_over_ws
RUN apt update -y
RUN apt install apt-transport-https ca-certificates -y
RUN wget -qO- 'https://dl.cloudsmith.io/public/qbittorrent-cli/qbittorrent-cli/gpg.F8756541ADDA2B7D.key' | sudo apt-key add -
RUN wget -q https://repos.fedarovich.com/debian/stretch/qbittorrent-cli.list
RUN mv qbittorrent-cli.list /etc/apt/sources.list.d/
RUN apt update -y
RUN apt install qbittorrent-cli -y
# Add other pakages before deployment 
# RUN apt install <your-pakage> -y
RUN mkdir /JupyterNotebooks
COPY JupyterNotebooks /JupyterNotebooks
COPY jupyter.py /conf/jupyter.py
COPY jupyter_notebook_config.json /root/.jupyter/jupyter_notebook_config.json

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh
