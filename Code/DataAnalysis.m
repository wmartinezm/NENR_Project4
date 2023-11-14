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
plot([0, 1000], [rheobase_x2, rheobase_x2], '--', 'Color', 'g', 'LineWidth', 1.5);

% Plot dashed line at rheobase threshold
plot([0, 1000], [rheobase, rheobase], '--', 'Color', 'm', 'LineWidth', 1.5);

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
