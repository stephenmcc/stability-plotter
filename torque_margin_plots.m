files = {};
rootDirName = 'Z:\Nadia\StephenFolder\2503_SRO\';

 dirName = '250327_1935_FirstRunAllReplay';
%dirName = '250327_2054_AllReplay';
%dirName = '250327_2106_FinalRun';
% dirName = '250328_0825_LowerGoodRun';

files{length(files) + 1} = strcat(rootDirName, dirName, '\baseline\data.scs2.mat');
files{length(files) + 1} = strcat(rootDirName, dirName, '\posture_contact\data.scs2.mat');

colors = {'black', 'red', 'yellow', 'green', 'blue', };
styles = {'--', '--', ':', '-.', '-'};

clf

fig = figure;
lineWidth = 3.0;

hold on
grid minor

[margin_avg_1, max_t] = plotTorqueMargin(files, 1, colors, styles, 'Shoulder Pitch');
[margin_avg_2, max_t] = plotTorqueMargin(files, 2, colors, styles, 'Shoulder Roll');
[margin_avg_3, max_t] = plotTorqueMargin(files, 3, colors, styles, 'Shoulder Yaw');
[margin_avg_4, max_t] = plotTorqueMargin(files, 4, colors, styles, 'Elbow Pitch');

margin_avg = (margin_avg_1 + margin_avg_2 + margin_avg_3 + margin_avg_4) / 4.0;
line([0.0 max_t], [margin_avg margin_avg], 'LineWidth', lineWidth, 'LineStyle', styles{5}, 'Color', [0 0 0]);
disp(margin_avg);

legend({"Shoulder Pitch", "Shoulder Roll", "Shoulder Yaw", "Elbow Pitch", "Average"}, 'Location', 'northwest', 'Orientation', 'vertical', 'Interpreter', 'latex', 'FontSize', 10)

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

function [margin_avg, max_t] = plotTorqueMargin(files, jointIndex, colors, styles, jointName)

lineWidth = 3.0;

[torque_margin, t] = loadFile(1, files, jointIndex);
[torque_margin_rt, t_rt] = loadFile(2, files, jointIndex);

min_size = min(size(t), size(t_rt));
torque_margin = torque_margin(1:min_size);
t = t(1:min_size);
torque_margin_rt = torque_margin_rt(1:min_size);
t_rt = t_rt(1:min_size);

max_t_element = t(size(t));
max_t = max_t_element(1);

torque_margin_delta = torque_margin_rt - torque_margin;

plot(t, torque_margin_delta, 'LineWidth', lineWidth, 'LineStyle', styles{jointIndex}); %, 'Color', colors{jointIndex});

margin_avg = mean(torque_margin_delta);

xlim([6,21])
ylim([-0.3 1.0])

title('Actuation Margin Comparison', 'Interpreter', 'latex')
xlabel('Time [s]', 'Interpreter', 'latex')
ylabel('Torque Margin $\%$ Variation ($\Delta m_{\tau}$)', 'Interpreter', 'latex')

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

end

function [torque_margin, t] = loadFile(fileIndex, files, jointIndex)
    file = files{fileIndex};
    load(file);

    m = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t = root.LogDataReader.robotTime;

    minIndex = getMinIndex(m, 0.0, Inf);    
    maxIndex = getMaxIndex(m, 0.0, Inf);

    t = t(minIndex:maxIndex);
    t = t - t(1);

    minIndexAdditional = getMinIndex(t, 6.0, Inf);
    maxIndexAdditional = getMaxIndex(t, 0.0, 25.0);
    
    m = m(minIndexAdditional:maxIndexAdditional);
    t = t(minIndexAdditional:maxIndexAdditional);

    tau_max_SHOULDER_Y = 41.50;
    tau_max_SHOULDER_X = 41.50;
    tau_max_SHOULDER_Z = 22.59;
    tau_max_ELBOW_Y = 22.59;

    if jointIndex == 1
        torque_margin = (abs(tau_max_SHOULDER_Y) - abs(root.main.DRCEstimatorThread.NadiaSensorReader.SensorProcessing.raw_tau_RIGHT_SHOULDER_Y)) / abs(tau_max_SHOULDER_Y);
    elseif jointIndex == 2
        torque_margin = (abs(tau_max_SHOULDER_X) - abs(root.main.DRCEstimatorThread.NadiaSensorReader.SensorProcessing.raw_tau_RIGHT_SHOULDER_X)) / abs(tau_max_SHOULDER_X);
    elseif jointIndex == 3
        torque_margin = (abs(tau_max_SHOULDER_Z) - abs(root.main.DRCEstimatorThread.NadiaSensorReader.SensorProcessing.raw_tau_RIGHT_SHOULDER_Z)) / abs(tau_max_SHOULDER_Z);
    else
        torque_margin = (abs(tau_max_ELBOW_Y)    - abs(root.main.DRCEstimatorThread.NadiaSensorReader.SensorProcessing.raw_tau_RIGHT_ELBOW_Y))    / abs(tau_max_ELBOW_Y);
    end

    torque_margin = torque_margin((minIndex + minIndexAdditional - 1):(minIndex + maxIndexAdditional - 1));    
end

function index = getMinIndex(m, minVal, maxVal)
for i = 1:length(m)
    if ~isinf(m(i)) && m(i) > minVal && m(i) < maxVal
        index = i;
        return;
    end
end
end

function index = getMaxIndex(m, minVal, maxVal)
for i = length(m):-1:1
    if ~isinf(m(i)) && m(i) > minVal && m(i) < maxVal
        index = i;
        return;
    end
end
end
