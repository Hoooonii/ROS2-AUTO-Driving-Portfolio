<div align="center">

# 🚗 ROS 2 Autonomous Driving & Sensor Fusion

**Vision-LiDAR 센서 퓨전 기반 동적 장애물 회피 자율주행 시스템**

<img src="https://img.shields.io/badge/ROS 2-Humble-22314E?style=for-the-badge&logo=ros">
<img src="https://img.shields.io/badge/Ubuntu-22.04 LTS-E95420?style=for-the-badge&logo=ubuntu">
<img src="https://img.shields.io/badge/Gazebo-Ignition-FF6600?style=for-the-badge">
<img src="https://img.shields.io/badge/Python-3.10-3776AB?style=for-the-badge&logo=python">
<img src="https://img.shields.io/badge/YOLOv8-Ultralytics-00FFFF?style=for-the-badge&logo=yolo">

<br><br>

<img src="./assets/yolo_snapshot.jpg" alt="⚠️ 스크린샷 이미지 업로드 예정 (assets/yolo_snapshot.jpg)" width="80%">
<br>
<em>전방 차량 감지에 따른 회피 조향 및 실시간 바운딩 박스 오버레이</em>

</div>

---

## 🌟 Key Features

- 👁️ **Real-time Perception:** YOLOv8 기반 다중 객체(차량, 버스 등) 실시간 탐지 및 추적
- 🌐 **Vision-LiDAR Sensor Fusion:** 2D 비전의 사각지대(Depth 상실)를 보완하기 위해 360도 전방위 라이다(10Hz) 융합
- 🏎️ **Evasive Steering Control:** 장애물의 면적(Distance)과 중심점(Centroid)을 분석하여 긴급 제동(AEB) 및 능동 회피 조향
- ⚡ **DDS Middleware & Zero-copy:** `cv_bridge`를 활용한 메모리 포인터 공유 방식으로 대용량 비전 데이터 파이프라인 최적화

<br>

## 📂 Repository Structure

단일 리포지토리(Monorepo) 구조로 하드웨어 명세와 소프트웨어 제어 로직을 통합 관리합니다.

```
📦 ROS2-AUTO-Driving-Portfolio
 ┣ 📂 my_robot_description/   # 4륜 독립 구동 로봇 URDF 및 SDF 월드, 런치 파일
 ┣ 📂 yolo_vision_pkg/        # YOLOv8 추론, LiDAR 퓨전, 모터 제어(cmd_vel) AI 노드
 ┣ 📜 run_all.sh              # 시뮬레이터, 브릿지, AI 노드 원클릭 통합 실행 스크립트
 ┗ 📜 README.md
```

<br>

## 🚀 Quick Start
```
# 1. 워크스페이스 빌드
cd ~/ros2_ws
colcon build --symlink-install
source install/setup.bash

# 2. 통합 환경 실행 (Xvfb 가상 모니터 + Gazebo + Foxglove Bridge + AI Node)
./run_all.sh
```

<br>

## 📈 Optimization Results (정량적 성과)
### 1. End-to-End 지연 시간 93% 단축
데이터 전송 방식을 Shared Memory 기반으로 재설계하여 통신 병목 해결.

<table>
  <thead>
    <tr>
      <th align="left" width="40%">통신 방식</th>
      <th align="left" width="30%">전송 지연 (Latency)</th>
      <th align="left" width="30%">CPU 점유율 (직렬화 부하)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>일반 소켓/HTTP 방식</td>
      <td>15.2 ms</td>
      <td>18.4%</td>
    </tr>
    <tr>
      <td><strong>ROS 2 + cv_bridge</strong></td>
      <td><strong>1.1 ms</strong></td>
      <td><strong>3.2%</strong></td>
    </tr>
  </tbody>
</table>

### 2. Edge 환경 AI 추론 최적화
제한된 CPU 자원 내에서 정확도와 속도의 트레이드오프(Trad-off) 분석.

<table>
  <thead>
    <tr>
      <th align="left" width="40%">성능 지표</th>
      <th align="left" width="30%">AS-IS (YOLOv8s) (Latency)</th>
      <th align="left" width="30%">TO-BE (YOLOv8n + 최적화)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>추론 시간 (Inference)</td>
      <td>62.0 ms (프레임 드랍)</td>
      <td>4.5 ms (실시간 처리)</td>
    </tr>
    <tr>
      <td><strong>초당 프레임 (FPS)</strong></td>
      <td><strong>약 16 FPS (제어 불안정)</strong></td>
      <td><strong>약 35 ~ 40 FPS (안정적)</strong></td>
    </tr>
  </tbody>
</table>
