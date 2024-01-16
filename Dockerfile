# ベースイメージの指定
FROM ubuntu:20.04

# インストールに必要なパッケージを更新
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# ROS 2の鍵を取得
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

# ROS 2のリポジトリを追加
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# ROS 2のセットアップスクリプトをコピー
COPY setup.sh /root/setup.sh

# ROS 2のインストール
RUN chmod +x /root/setup.sh && /root/setup.sh

# インタラクティブなシェルの起動
CMD ["/bin/bash"]

