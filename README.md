FMCW Radar Signal Processing and Machine Learning Classification
Project Overview

This project presents an industry-oriented implementation of an end-to-end FMCW radar signal processing and machine learning system for object detection and classification. The work demonstrates how raw radar signals are transformed through digital signal processing stages into meaningful representations that can be used by machine learning algorithms to classify different target behaviors. The project reflects real-world radar development workflows commonly used in automotive, defense, and RF sensing applications.

System Description

The system is built around a complete FMCW radar processing chain. Frequency-modulated chirps are generated and used to model transmitted and received radar signals. The received echoes are processed to extract beat frequencies, which contain information about target range and motion. These signals are further analyzed using frequency-domain and time-frequency techniques in order to generate features suitable for machine learning.

Radar Signal Processing

The radar processing stage includes FFT-based range estimation, Doppler processing across multiple chirps for velocity estimation, and time-frequency analysis using techniques such as the Short-Time Fourier Transform. These stages enable the generation of range profiles, Doppler spectra, and micro-Doppler signatures that characterize target motion and dynamics. The processing chain is implemented in a modular manner, similar to production radar DSP pipelines.

Feature Engineering and Machine Learning

Following signal processing, relevant features are extracted from the radar representations. These features include spectral, temporal, and statistical characteristics derived from range, Doppler, and time-frequency data. The extracted features are used to train supervised machine learning classifiers such as Support Vector Machines, k-Nearest Neighbors, and Random Forest models. The design allows straightforward extension to deep learning approaches, including convolutional neural networks.

Model Evaluation

The machine learning models are evaluated using standard performance metrics in order to assess classification accuracy and robustness. The evaluation process includes comparison between different models and feature sets, providing insight into the trade-offs between complexity and performance. This evaluation methodology reflects practices commonly used in applied machine learning and signal processing projects.

Software Architecture

The software is structured to emphasize clarity, scalability, and reusability. The project is divided into dedicated modules for radar signal processing, feature extraction, machine learning, and evaluation. This structure mirrors industry-standard development practices and enables easy modification, testing, and future expansion of the system.

Tools and Technologies

The implementation is based on Python and widely used scientific and machine learning libraries. Numerical computation and signal processing are handled using NumPy and SciPy, visualization is performed with Matplotlib, and machine learning models are implemented using Scikit-learn. The project integrates radar DSP concepts with modern data-driven techniques in a unified software framework.

##  Results

### 1️⃣ Range–Doppler Map
The first figure shows the **Range–Doppler Map**, where each bright region corresponds to a simulated target at a particular range and radial velocity.

| Range–Doppler Map |
|-------------------|
| ![Range–Doppler Map](docs/images/range_doppler.jpg) |

---

### 2️⃣ Micro-Doppler-Like Signature
At the strongest range bin, the script extracts the slow-time signal and computes a **spectrogram**, giving a micro-Doppler-like signature that reflects the velocity variations of the target over time.

| Micro-Doppler Spectrogram |
|---------------------------|
| ![Micro-Doppler Spectrogram](docs/images/micro_doppler.jpg) |

---

### 3️⃣ ML Feature Space
The final figure shows the **feature space** (e.g., mean vs max velocity) with different classes labelled, giving intuition about how well the RF-inspired features separate Human, Car, and Drone motion.

| Feature Space (Human / Car / Drone) |
|-------------------------------------|
| ![Feature Space](docs/images/ML.jpg) |

The script prints the **classification accuracy** in the MATLAB command window, giving a quick sense of how well the simple SVM model performs on the synthetic dataset.
