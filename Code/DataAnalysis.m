%% Fig 2 - Strength-Duration Curve in MATLAB

% Define parameters
pulse_widths = [100, 200, 300, 650, 800]; % Pulse widths in microseconds
current_thresholds = [5, 4, 3, 2, 1.75]; % Corresponding current thresholds in mA

% Create a higher-resolution line for smoothing
smooth_pulse_widths = linspace(0, 1000);
smooth_current_thresholds = interp1(pulse_widths, current_thresholds, smooth_pulse_widths, 'pchip');

% Plot the strength-duration curve with a smoother line
figure;
plot(smooth_pulse_widths, smooth_current_thresholds, 'b-', 'LineWidth', 2);
hold on;
scatter(pulse_widths, current_thresholds, 100, 'r', 'filled'); % Plot original points

% Plot dashed line at the lowest current threshold
rheobase_x2 = min(current_thresholds);
rheobase = rheobase_x2 / 2;

% Plot dashed line at the 2 x rheobase current threshold
plot([0, 1000], [rheobase_x2, rheobase_x2], ':', 'Color', 'g', 'LineWidth', 1.5);

% Plot dashed line at rheobase threshold
plot([0, 1000], [rheobase, rheobase], '-.', 'Color', 'm', 'LineWidth', 1.5);

xlabel('Pulse Width (us)');
ylabel('Current Threshold (mA)');
title('Strength-Duration Curve with Smoothing');
grid on;

% Set x-axis and y-axis limits
xlim([0 1000]); % Adjusted x-axis limit to 1000 microseconds
ylim([0 6]);    % Adjusted y-axis limit to 6 mA

% Define a colormap for different colors
colors = colormap(lines(length(pulse_widths)));
% Draw boxes for each pair of pulse width and current threshold with different colors
for i = 1:length(pulse_widths)
    rectangle('Position', [0, 0, pulse_widths(i), current_thresholds(i)], 'EdgeColor', colors(i, :));
end

% Add a legend for the dashed lines
legend({'Curve', 'Original Points', '2 x Rheobase', 'Rheobase'}, 'Location', 'Best');
%% Fig 3 Performance Metric Analysis
% Define stimulation parameters
amp_flexor = 3.00; % Amplitude for Flexor condition (mA)
pulse_width_flexor = 300; % Pulse width for Flexor condition (us)
amp_ulnar = 5.00; % Amplitude for Ulnar condition (mA)
pulse_width_ulnar = 150; % Pulse width for Ulnar condition (us)
frequency = 30; % Stimulation frequency (Hz)
duration = 250; % Duration of stimulation (us)

% Participant displacement data (arbitrary units)
displacement_data = [
    1.7, 1, 0.75; % Flexor, Trial 1
    1.4, 0.5, 1.9; % Flexor, Trial 2
    1.4, 1, 1.3;   % Flexor, Trial 3
    0.9, 0.5, 1.2; % Flexor, Trial 4
    1, 1, 1.3;     % Flexor, Trial 5
    1.25, 0.5, 1.2; % Flexor, Trial 6
    3.3, 0.6, 0.4; % Ulnar, Trial 7
    4.5, 1.1, 0.8; % Ulnar, Trial 8
    4.8, 1.2, 0.4; % Ulnar, Trial 9
    2.5, 0.5, 0.4; % Ulnar, Trial 10
    4.1, 0.4, 0.7; % Ulnar, Trial 11
    4.65, 0.4, 0.4 % Ulnar, Trial 12
];

% Calculate average displacement for each condition and trial
average_displacement_flexor = mean(displacement_data(1:6, :));
average_displacement_ulnar = mean(displacement_data(7:12, :));

% Display results
disp('Average Displacement for Flexor Condition:');
disp(average_displacement_flexor);

disp('Average Displacement for Ulnar Condition:');
disp(average_displacement_ulnar);

%% Fig 4
% Location --> Flexor = 1
%          --> Ulnar = 2

% Input data - replace with your actual data
trial_data = [
    1, 1, 1.7, 1, 0.75; 
    2, 1, 1.4, 0.5, 1.9; 
    3, 1, 1.4, 1, 1.3; 
    4, 1, 0.9, 0.5, 1.2; 
    5, 1, 1, 1, 1.3; 
    6, 1, 1.25, 0.5, 1.2; 
    7, 2, 3.3, 0.6, 0.4; 
    8, 2, 4.5, 1.1, 0.8; 
    9, 2, 4.8, 1.2, 0.4; 
    10, 2, 2.5, 0.5, 0.4; 
    11, 2, 4.1, 0.4, 0.7; 
    12, 2, 4.65, 0.4, 0.4
];

% Extracting data
location_1_data = trial_data(trial_data(:, 2) == 1, 3:5);
location_2_data = trial_data(trial_data(:, 2) == 2, 3:5);

% Jarque-Bera test for normality
[h_jb_location_1, p_value_jb_location_1] = jbtest(median(location_1_data));
[h_jb_location_2, p_value_jb_location_2] = jbtest(median(location_2_data));

% Generating bar plot
figure;
subplot(2, 1, 1);
bar(1:3, mean(location_1_data), 'b');
hold on;
bar(4:6, mean(location_2_data), 'r');
errorbar([1:3, 4:6], [mean(location_1_data), mean(location_2_data)], ...
         [std(location_1_data), std(location_2_data)] / sqrt(size(location_1_data, 1)), ...
         '.', 'Color', 'k');
xticks(1:6);
xticklabels({'Participant 1', 'Participant 2', 'Participant 3', 'Participant 1', 'Participant 2', 'Participant 3'});
ylabel('Mean Finger Displacement');
title('Bar Plot of Mean Finger Displacement for Location 1 and Location 2');

subplot(2, 1, 2);
bar(1:3, p_value_jb_location_1, 'b');
hold on;
bar(4:6, p_value_jb_location_2, 'r');
xticks(1:6);
xticklabels({'Participant 1', 'Participant 2', 'Participant 3', 'Participant 1', 'Participant 2', 'Participant 3'});
ylabel('p-value (Jarque-Bera test)');
title('Bar Plot of Jarque-Bera Test p-values for Location 1 and Location 2');

