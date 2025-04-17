files = {};
labels = {};

rootDirName = 'Z:\Nadia\StephenFolder\2503_SRO\';

dirName = '250327_1935_FirstRunAllReplay';
% dirName = '250327_2054_AllReplay';
% dirName = '250327_2106_FinalRun';
% dirName = '250328_0825_LowerGoodRun';

files{length(files) + 1} = strcat(rootDirName, dirName, '\baseline\data.scs2.mat');
% labels{length(labels) + 1} = 'Baseline';
labels{length(labels) + 1} = 'Optimizer Disabled';

files{length(files) + 1} = strcat(rootDirName, dirName, '\posture_contact\data.scs2.mat');
labels{length(labels) + 1} = 'Optimizer Enabled';
% labels{length(labels) + 1} = 'Posture + Contact';

colors = {'black', 'red', 'yellow', 'green', 'blue', };
styles = {'-', '--', '--', ':', '-.', '-.'};

clf

t = tiledlayout(2,2, "TileSpacing","tight");
nexttile

hold on
grid minor
plotTorqueMargin(files, 1, colors, styles, 'Shoulder Pitch')

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

nexttile

hold on
grid minor

plotTorqueMargin(files, 2, colors, styles, 'Shoulder Roll')
nexttile

hold on
grid minor

plotTorqueMargin(files, 3, colors, styles, 'Shoulder Yaw')
ylim([-0.15, 1.0])

nexttile

hold on
grid minor

plotTorqueMargin(files, 4, colors, styles, 'Elbow Pitch')

% fig = figure;
% lineWidth = 3.0;
% 
% colors = {'black', 'red', 'yellow', 'green', 'blue', };
% styles = {'-', '-.', '--', ':', '-.', '-.'};
% plots = [];
% 
% shoulder_y_margins = [];
% shoulder_x_margins = [];
% shoulder_z_margins = [];
% elbow_y_margins = [];
% 
% t = tiledlayout(2,1, "TileSpacing","tight");
% nexttile
% 
% hold on
% grid minor
% 
% p1 = plot(t, shoulder_y_margins(1), 'LineWidth', lineWidth, 'LineStyle', styles{i}, 'Color', colors{1});
% p2 = plot(t, shoulder_y_margins(2), 'LineWidth', lineWidth, 'LineStyle', styles{i}, 'Color', colors{2});
% 
% xlim([6,21])
% ylim([-0.2 1.2])
% 
% ax = gca;
% ax.TickLabelInterpreter = 'latex';
% ax.FontSize = 20;
% 
% title('Shoulder Y Torque Margin', 'Interpreter', 'latex')
% 
% xlabel('Time [s]', 'Interpreter', 'latex')
% ylabel('Torque Margin Percentage', 'Interpreter', 'latex')
% 
% 
% nexttile
% 
% hold on
% grid minor
% 
% p1 = plot(t, shoulder_x_margins(1), 'LineWidth', lineWidth, 'LineStyle', styles{i}, 'Color', colors{1});
% p2 = plot(t, shoulder_x_margins(2), 'LineWidth', lineWidth, 'LineStyle', styles{i}, 'Color', colors{2});
% 
% xlim([6,21])
% ylim([-0.2 1.2])
% 
% ax = gca;
% ax.TickLabelInterpreter = 'latex';
% ax.FontSize = 20;
% 
% title('Shoulder Y Torque Margin', 'Interpreter', 'latex')
% 
% xlabel('Time [s]', 'Interpreter', 'latex')
% ylabel('Torque Margin Percentage', 'Interpreter', 'latex')

function plotTorqueMargin(files, jointIndex, colors, styles, jointName)

lineWidth = 3.0;

[torque_margin, t] = loadFile(1, files, jointIndex);
plot(t, torque_margin, 'LineWidth', lineWidth, 'LineStyle', styles{1}, 'Color', colors{1});
m = mean(torque_margin);
m_vector = m * ones(size(t));
p = plot(t, m_vector, 'LineWidth', lineWidth * 0.3, 'LineStyle', styles{1}, 'Color', colors{1});

[torque_margin, t] = loadFile(2, files, jointIndex);
plot(t, torque_margin, 'LineWidth', lineWidth, 'LineStyle', styles{2}, 'Color', colors{2});
m = mean(torque_margin);
m_vector = m * ones(size(t));
p = plot(t, m_vector, 'LineWidth', lineWidth * 0.3, 'LineStyle', styles{2}, 'Color', colors{2});

legend({"Without Retargeting", "Without Retargeting (avg)", "With Retargeting", "With Retargeting (avg)"}, 'Location', 'southwest', 'Orientation', 'vertical', 'Interpreter', 'latex', 'FontSize', 10)

if jointIndex == 1
    xlbl = xlabel('Time [s]', 'Interpreter', 'latex', 'Position', [20.0 0.175 -1]);
elseif jointIndex == 2
    xlbl = xlabel('Time [s]', 'Interpreter', 'latex', 'Position', [20.0 0.175 -1]);    
elseif jointIndex == 3
    xlbl = xlabel('Time [s]', 'Interpreter', 'latex', 'Position', [20.0 0.04 -1]);
else
    xlbl = xlabel('Time [s]', 'Interpreter', 'latex', 'Position', [20.0 0.175 -1]);
end

title(strcat(jointName,' Torque Margin Percentage'), 'Interpreter', 'latex')

xlim([6,21])
ylim([0.0 1.0])

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

% disp(ax.Units);

end

function [torque_margin, t] = loadFile(fileIndex, files, jointIndex)
    file = files{fileIndex};
    load(file);

    m = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t = root.LogDataReader.robotTime;
    minIndex = getMinIndex(m, 0.0);
    maxIndex = getMaxIndex(m, 0.0);

    t = t(minIndex:maxIndex);
    t = t - t(1);

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

    torque_margin = torque_margin(minIndex:maxIndex);
end

function index = getMinIndex(m, minVal)
for i = 1:length(m)
    if ~isinf(m(i)) && m(i) > minVal
        index = i;
        return;
    end
end
end

function index = getMaxIndex(m, minVal)
for i = length(m):-1:1
    if ~isinf(m(i)) && m(i) > minVal
        index = i;
        return;
    end
end
end
