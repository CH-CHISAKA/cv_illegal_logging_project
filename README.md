
CV_Illegal_Logging_Project
================================
Overview

Illegal logging in Kenyan forests poses a serious threat to biodiversity, climate resilience, and local livelihoods. Traditional monitoring methods—manual patrols, satellite imagery, aerial surveillance—are costly, slow, and reactive, especially in remote forest regions.

This project introduces a proactive, technology-driven solution combining:

A Flutter Web interface for monitoring, visualization, and alert management

A computer vision and machine learning pipeline that detects illegal logging indicators (chainsaws, pangas, unauthorized vehicles, timber) in real-time

Edge computing deployment for low-power, low-connectivity environments

The system empowers stakeholders with timely information to prevent illegal logging, supports Sustainable Development Goal 15 (Life on Land), and offers a replicable conservation framework for African ecosystems.

-----------------
Architecture
-----------------

[Forest Camera / Edge Device]  →  [ML Computer Vision Pipeline (Python + TFLite)]  →  [Backend Server / API]  →  [Flutter Web Frontend]

-----------------
Features
-----------------

Flutter Web Dashboard:

* Live feed visualization

* Real-time illegal logging alerts

* Historical data and analytics

* User authentication and role-based access

Computer Vision Pipeline:

* Detects visual indicators: chainsaws, pangas, unauthorized vehicles, timber

* Optimized lightweight models for edge inference

* Works offline with batch sync when connectivity returns

--------------------
Technologies Used
--------------------

* Frontend: Flutter Web (Dart)

* Backend: Python (Flask/FastAPI or similar)

* ML/Computer Vision: PyTorch Mobile, OpenCV

* Edge Devices: Raspberry Pi, NVIDIA Jetson, or equivalent

* Database: Supabase / Firebase (depending on implementation)

---------------------
Setup & Installation
---------------------

1. Flutter Web Frontend

* Clone the repo and navigate to the frontend directory

* Install Flutter SDK if not already installed

    Run:

    flutter pub get

    flutter run -d chrome   //change depending on the browser. ## flutter run -d edge - running with Edge or Firefox (if installed) ## flutter run -d web-server

* The web dashboard will be available at http://localhost:8080


* Run the following command to generate a release build:
    
    flutter build web

    flutter serve

* Build your app using WebAssembly
* You can also pass the --wasm flag to build your app using WebAssembly:
    
    flutter build web --wasm

--------------------
Usage
--------------------
* Access Flutter Web dashboard via browser to monitor detections and alerts

--------------------
Roadmap
--------------------
* Integrate SMS/email push notifications for alerts

* Enhance Flutter Web dashboard with map visualizations

--------------------
Acknowledgements
--------------------

This project supports the United Nations’ SDG 15 (Life on Land) through innovative technology solutions for environmental conservation.























