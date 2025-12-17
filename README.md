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

Industry Relevance

This project is directly relevant to real-world applications such as automotive radar systems, surveillance and defense platforms, RF sensing solutions, and motion or activity recognition systems. It demonstrates the ability to bridge theoretical radar concepts with practical signal processing and machine learning implementation, a key requirement in modern radar and RF engineering roles.

License

The project is released under the MIT License, allowing free use, modification, and distribution for both academic and commercial purposes.

Author

Developed as an Electrical Engineering project with a focus on radar systems, RF signal processing, and machine learning, intended for use as a professional engineering portfolio project.
