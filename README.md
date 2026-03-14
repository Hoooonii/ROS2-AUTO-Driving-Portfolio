# 🚗 ROS 2 Autonomous Driving & Sensor Fusion Portfolio

본 프로젝트는 **ROS 2 Humble** 미들웨어와 **Ignition Gazebo**를 활용하여 실시간 비전 인지(YOLOv8) 및 동적 장애물 회피 제어(Vision-LiDAR Fusion) 알고리즘을 구현한 자율주행 소프트웨어 스택입니다. 
Apple Silicon (M3) 가상머신 환경의 한계를 극복하기 위해 클라우드 네이티브 수준의 Headless 시뮬레이션 및 분산 모니터링 아키텍처를 도입했습니다.



## 🌟 Key Features

### 1. Multi-Sensor Fusion (Vision + LiDAR)
- **비전 인지 (YOLOv8):** 다중 객체(차량 등)를 실시간으로 탐지하고 Bounding Box의 중심점과 면적을 계산.
- **물리 거리 측정 (LiDAR):** 2D 비전의 사각지대(Depth 상실)를 보완하기 위해 360도 전방위 라이다 데이터를 10Hz로 수신.
- **융합 회피 제어 (Evasive Steering):** 비전이 장애물을 인식하면, 라이다가 좌우 여유 공간을 계산하여 안전한 방향으로 회피 조향(`angular.z`) 자동 수행.

### 2. Cloud-Native Simulation Architecture
- **Headless & Xvfb Optimization:** Mac VM 환경의 GPU 한계(Ogre2 Crash)를 우회하기 위해 `Xvfb` 가상 프레임버퍼와 `Ogre1` 엔진 채택. GUI 렌더링 부하를 제거하여 자원을 100% 물리 연산에 집중.
- **Distributed Monitoring:** `foxglove_bridge`를 통해 시뮬레이터의 실시간 토픽을 외부 호스트(Mac)의 Foxglove Studio로 Zero-Latency 스트리밍.

### 3. Middleware Optimization (Fast DDS)
- **Zero-copy Pipeline:** `cv_bridge`를 활용한 메모리 포인터 공유 방식으로 대용량 비전 데이터 처리 시 발생하는 직렬화 오버헤드 완벽 제거.

## 🛠 Tech Stack
- **OS / Middleware:** Ubuntu 22.04 LTS / ROS 2 Humble (Fast DDS)
- **Simulator / Tool:** Gazebo Ignition (Fortress) / Foxglove Studio
- **AI / Vision:** Ultralytics YOLOv8n / OpenCV, cv_bridge
- **Language:** Python 3.10 / XML (URDF, SDF 1.8)

## 📂 Repository Structure
단일 리포지토리(Monorepo)에서 하드웨어 명세와 소프트웨어 제어 로직을 통합 관리합니다.
```text
📦 ROS2-AUTO-Driving-Portfolio
 ┣ 📂 my_robot_description/   # 4륜 독립 구동 로봇 URDF 및 SDF 월드, 런치 파일
 ┣ 📂 yolo_vision_pkg/        # YOLOv8 추론, LiDAR 퓨전, 모터 제어(cmd_vel) AI 노드
 ┣ 📜 run_all.sh              # 시뮬레이터, 브릿지, AI 노드 원클릭 통합 실행 쉘 스크립트
 ┗ 📜 README.md
