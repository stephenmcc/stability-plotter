files = {};
labels = {};

plot_area = false;
hardware = false;

if hardware
    rootDirName = 'Z:\Nadia\StephenFolder\2503_SRO\';

    dirName = '250327_1935_FirstRunAllReplay';
    % dirName = '250327_2054_AllReplay';
    % dirName = '250327_2106_FinalRun';
    % dirName = '250328_0825_LowerGoodRun';

    files{length(files) + 1} = strcat(rootDirName, dirName, '\baseline\data.scs2.mat');
    labels{length(labels) + 1} = 'Retargeting Disabled';

    files{length(files) + 1} = strcat(rootDirName, dirName, '\posture_contact\data.scs2.mat');
    labels{length(labels) + 1} = 'Retargeting Enabled';

    colors = {'black', 'red', 'yellow', 'green', 'blue', };
    styles = {'-', '-.', '--', ':', '-.', '-.'};
else
    rootDirName = 'C:\Users\smccrory\Documents\Simulation Data\';
    
    % dirName = 'wall0_pitched';
    % dirName = 'wall_top4';
    % dirName = 'wall_back2';
    dirName = 'wall_uneven';

    files{length(files) + 1} = strcat(rootDirName, dirName, '\baseline\data.scs2.mat');
    labels{length(labels) + 1} = 'Without Retargeting';

    files{length(files) + 1} = strcat(rootDirName, dirName, '\posture\data.scs2.mat');
    labels{length(labels) + 1} = 'Posture Retargeting';
    
    % files{length(files) + 1} = strcat(rootDirName, dirName, '\contact\data.scs2.mat');
    % labels{length(labels) + 1} = 'Contact Retargeting';

    % files{length(files) + 1} = strcat(rootDirName, dirName, '\posture_contact\data.scs2.mat');
    % labels{length(labels) + 1} = 'Posture + Contact Retargeting';

    colors = {'black', 'green', 'blue', 'red', 'yellow'};
    styles = {'-', '--', ':', '-.', '-.', '-.'};
end

fig = figure;
lineWidth = 3.0;

plots = [];

for i = 1:length(files)
    file = files{i};
    load(file);

    if hardware
        m = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
        t = root.LogDataReader.robotTime;
        a = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
    else
        m = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
        t = root.('time[sec]');
        a = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
    end

    minIndex = getMinIndex(m, 0.0);
    maxIndex = getMaxIndex(m, 0.0);

    m = m(minIndex:maxIndex);
    t = t(minIndex:maxIndex);
    a = a(minIndex:maxIndex);
    t = t - t(1);
    
    if plot_area
        d = a;
    else
        d = m;
    end

    p = plot(t, d, 'LineWidth', lineWidth, 'LineStyle', styles{i}, 'Color', colors{i});
    plots = [plots p];
    hold on
end

m_h = 0.135;
m_h_vector = m_h * ones(size(t));
p = plot(t, m_h_vector, 'LineWidth', lineWidth * 0.42, 'Color', [125 125 125]./255);
plots = [plots p];
labels{length(labels) + 1} = '$m_h$';

if hardware
    xlim([6 21])
else
   xlim([1.5,18])
end

ylim([0 0.2])

hold off

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 20;

if hardware
    title('CoM Stability Margin - Hardware', 'Interpreter', 'latex')
else
    title('CoM Stability Margin - Simulation Scenario (a)', 'Interpreter', 'latex')
end

plts = fig.Children.Children;

lgd = legend(plots, labels, 'Interpreter', 'latex', 'FontSize', 16);
lgd.Location = 'southwest';
grid minor

xlabel('Time [s]', 'Interpreter', 'latex')

if plot_area
    ylabel('CoM Stability Area [m^2]', 'Interpreter', 'latex')
else
    ylabel('CoM Stability Margin [m]', 'Interpreter', 'latex')
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
