#!/bin/bash

#apt-getリポジトリの追加
apt-get install curl gnupg lsb-release -y
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

#リポジトリをsource listに追加
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null

#ROS2インストール
apt-get update
apt-get install ros-humble-desktop -y

#環境設定
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

#ワークスペースの作成
apt-get install python3-colcon-common-extensions -y
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/ && colcon build

#環境設定を反映
source ~/.bashrc

