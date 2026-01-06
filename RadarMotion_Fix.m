% =========================================================================
% FMCW Radar Simulation: Direct IF + Anti-Aliasing Fix + Windowing
%
% CORRECTIONS IMPLEMENTED:
% 1. Velocity Fix: Tchirp shortened to 20us to support 30m/s velocity.
% 2. Range Fix: Fs increased to 10MHz to support the new slope.
% 3. Visuals: Added 'hann window' to remove sidelobes (ripples).
% =========================================================================
clear; close all; clc;

%% ========================================================================
%  PART A: RADAR PARAMETERS & SCENE
% ========================================================================
c       = 3e8;           % Speed of light (m/s)
fc      = 77e9;          % Carrier frequency (77 GHz)
lambda  = c/fc;          % Wavelength

% --- CRITICAL PARAMETER FIX FOR HIGH VELOCITY ---
B       = 150e6;          % Bandwidth (150 MHz)
Tchirp  = 20e-6;          % Shortened from 40us to 20us (Supports max vel ~48 m/s)
slope   = B / Tchirp;     % Slope of the chirp

% --- SAMPLING RATE ADJUSTMENT ---
% Because Tchirp is shorter, the slope is steeper, leading to higher beat frequencies.
Fs      = 10e6;           % Increased Sampling Rate to 10MHz
Ns      = round(Tchirp * Fs); % Number of samples per chirp
Nchirps = 128;            % Number of chirps in one frame

% Time axes
t_fast = (0:Ns-1) / Fs;             % Fast time (within a chirp)
t_slow = (0:Nchirps-1) * Tchirp;    % Slow time (across chirps)

% Define Targets [Range (m), Velocity (m/s), Amplitude]
targets = [ ...
    40,   0,    1.0;   % Target 1: Stationary
    60,   15,   0.8;   % Target 2: Receding
    80,  -30,   0.6];  % Target 3: Fast Approach (Correctly shown now!)

Nt = size(targets,1);

%% ========================================================================
%  PART B: SIGNAL GENERATION (DIRECT MIXER SIMULATION)
% ========================================================================
mix_signal = zeros(Nchirps, Ns);

for i = 1:Nt
    R   = targets(i,1);
    v   = targets(i,2);
    amp = targets(i,3);
    
    % Calculate frequencies
    f_beat    = (slope * 2 * R) / c;     
    f_doppler = (2 * v) / lambda;        
    
    % Generate Phase (Beat Frequency + Doppler Shift)
    phase = 2 * pi * (f_beat * t_fast + f_doppler * t_slow.');
    
    % Accumulate signal
    mix_signal = mix_signal + (amp * exp(1j * phase));
end

% Add Gaussian Noise
mix_signal = awgn(mix_signal, 15, 'measured');

%% ========================================================================
%  PART C: DSP WITH WINDOWING (For Clean Visuals)
% ========================================================================

% 1. Range FFT (With Hann window to reduce Range Sidelobes)
win_range  = hann(Ns)'; 
mix_windowed = mix_signal .* win_range; % Apply window
Nfft_range = 2^nextpow2(Ns); 
range_fft  = fft(mix_windowed, Nfft_range, 2);
range_fft  = range_fft(:, 1:Nfft_range/2); % Keep positive half

% Range Axis Calculation
f_beat_axis = (0:(Nfft_range/2-1)) * (Fs / Nfft_range);
range_axis  = (c * f_beat_axis) / (2 * slope);

% 2. Doppler FFT (With Hann window to reduce Velocity Sidelobes)
win_doppler = hann(Nchirps);
% Apply window across chirps (dimension 1)
range_fft_windowed = range_fft .* win_doppler; 

Nfft_dopp = 256; 
% FFT across slow time + Shift zero frequency to center
rdm = fftshift(fft(range_fft_windowed, Nfft_dopp, 1), 1);

% Velocity Axis Calculation
PRF = 1 / Tchirp; 
fd_axis = linspace(-PRF/2, PRF/2, Nfft_dopp);
vel_axis = (fd_axis * lambda) / 2;

%% ========================================================================
%  PART D: PLOTTING
% ========================================================================
figure('Name', 'Final Corrected RDM', 'Color', 'w');
imagesc(range_axis, vel_axis, 20*log10(abs(rdm)));
axis xy; colormap('jet'); colorbar;

xlabel('Range (m)');
ylabel('Velocity (m/s)');
title('Corrected Range-Doppler Map (Valid Velocities up to \pm48 m/s)');

% Set plot limits for better visibility
xlim([0 100]); 
ylim([-40 40]); 
clim([-20 50]); % Adjust contrast

grid on;

% Add labels to the targets on the plot
text(40, 2, 'Target 1 (0 m/s)', 'Color', 'w', 'FontSize', 8);
text(60, 17, 'Target 2 (15 m/s)', 'Color', 'w', 'FontSize', 8);
text(80, -28, 'Target 3 (-30 m/s)', 'Color', 'w', 'FontSize', 8);