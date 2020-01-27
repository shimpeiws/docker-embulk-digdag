FROM openjdk:8-jdk-stretch

RUN apt-get update \
  && apt-get install curl \
  && apt-get install -y gcc g++ tar wget make cmake bzip2 zlib1g-dev g++-multilib \
  && apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Install embulk
RUN curl --create-dirs -o ~/.embulk/bin/embulk -L "https://dl.embulk.org/embulk-latest.jar" \
  && chmod +x ~/.embulk/bin/embulk \
  && echo 'export PATH="$HOME/.embulk/bin:$PATH"' >> ~/.bashrc

# Install digdag
RUN curl -o ~/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" \
  && chmod +x ~/bin/digdag \
  && echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc

# Install rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV PATH /root/.rbenv/shims:/root/.rbenv/bin:$PATH

# Install ruby-build & ruby
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && \
    ~/.rbenv/bin/rbenv install 2.7.0 && \
    ~/.rbenv/bin/rbenv global 2.7.0

# Install bundler
RUN ~/.rbenv/bin/rbenv exec gem install bundler -v 2.1.4