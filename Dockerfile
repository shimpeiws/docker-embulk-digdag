FROM openjdk:8-jdk-stretch

RUN apt-get update \
  && apt-get install curl

# Install embulk
RUN curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar" \
  && chmod +x ~/.embulk/bin/embulk \
  && echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> ~/.bashrc

# Install digdag
RUN curl -o ~/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x ~/bin/digdag \
  && echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
