#!/bin/bash

echo "🔥 [System] 부팅 시작..."

killall -9 ruby ign gzserver gzclient Xvfb 2>/dev/null
pkill -f "ros2 launch" 2>/dev/null
pkill -f "yolo_node" 2>/dev/null
pkill -f "foxglove_bridge" 2>/dev/null
sleep 2

source /opt/ros/humble/setup.bash
source ~/ros2_ws/install/setup.bash

export LIBGL_ALWAYS_SOFTWARE=1

echo "🌍 [Gazebo] 가상 모니터(Xvfb) 환경에서 Ignition Gazebo 실행 중..."
xvfb-run -a ros2 launch my_robot_description spawn_robot.launch.py &

sleep 8 

echo "🌐 [Network] Foxglove Websocket 브릿지 서버 개방 (포트: 8765)"
ros2 run foxglove_bridge foxglove_bridge &

echo "🧠 [AI Vision] 테슬라 비전 V2.1 노드 가동!"
python3 ~/ros2_ws/src/yolo_vision_pkg/yolo_vision_pkg/yolo_node.py

trap "pkill -f 'ros2 launch'; pkill -f 'yolo_node'; pkill -f 'foxglove_bridge'; killall -9 ruby ign Xvfb" EXIT