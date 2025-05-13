colors = {'black', 'blue', 'green', 'red'};
styles = {'-', '--', ':', '-.', '-.', '-.'};

clf

t = tiledlayout(1,3, "TileSpacing","tight");
nexttile

hold on
grid minor
plotMargin(1, colors, styles)

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

nexttile

hold on
grid minor

plotMargin(2, colors, styles)
nexttile

hold on
grid minor

plotMargin(3, colors, styles)

function plotMargin(scenarioIndex, colors, styles)

lineWidth = 3.0;

[margin, t] = loadFile(scenarioIndex, 1);
plot(t, margin, 'LineWidth', lineWidth, 'LineStyle', styles{1}, 'Color', colors{1});

[margin, t] = loadFile(scenarioIndex, 2);
plot(t, margin, 'LineWidth', lineWidth, 'LineStyle', styles{2}, 'Color', colors{2});

[margin, t] = loadFile(scenarioIndex, 3);
plot(t, margin, 'LineWidth', lineWidth, 'LineStyle', styles{3}, 'Color', colors{3});

[margin, t] = loadFile(scenarioIndex, 4);
plot(t, margin, 'LineWidth', lineWidth, 'LineStyle', styles{4}, 'Color', colors{4});

[margin, t] = loadFile(scenarioIndex, 1);
m_vector = mean(margin) * ones(size(t));
p = plot(t, m_vector, 'LineWidth', lineWidth * 0.3, 'LineStyle', styles{1}, 'Color', colors{1}, 'LineStyle', styles{1});
disp(strcat('Scenario ',num2str(scenarioIndex),' Avg, without retargeting: ', num2str(mean(margin))));

[margin, t] = loadFile(scenarioIndex, 2);
m_vector = mean(margin) * ones(size(t));
p = plot(t, m_vector, 'LineWidth', lineWidth * 0.3, 'LineStyle', styles{1}, 'Color', colors{2}, 'LineStyle', styles{2});
disp(strcat('Scenario ',num2str(scenarioIndex),' Avg, posture-only: ', num2str(mean(margin))));

[margin, t] = loadFile(scenarioIndex, 3);
m_vector = mean(margin) * ones(size(t));
p = plot(t, m_vector, 'LineWidth', lineWidth * 0.3, 'LineStyle', styles{1}, 'Color', colors{3}, 'LineStyle', styles{3});
disp(strcat('Scenario ',num2str(scenarioIndex),' Avg, contact-only: ', num2str(mean(margin))));

[margin, t] = loadFile(scenarioIndex, 4);
m_vector = mean(margin) * ones(size(t));
p = plot(t, m_vector, 'LineWidth', lineWidth * 0.3, 'LineStyle', styles{1}, 'Color', colors{4}, 'LineStyle', styles{4});
disp(strcat('Scenario ',num2str(scenarioIndex),' Avg, with retargeting:    ', num2str(mean(margin))));

if scenarioIndex == 1
    xMax = 18.0;
    yMax = 0.2;
elseif scenarioIndex == 2
    xMax = 14.0;
    yMax = 0.25;
else
    xMax = 12.5;
    yMax = 0.18;
end

xlim([0 xMax]);
ylim([0 yMax]);
xlabel('Time [s]', 'Interpreter', 'latex', 'Position', [0.9*xMax 0.08*yMax -1.0000]);

if scenarioIndex == 1
    title('Front Contact (Pushing Back)', 'Interpreter', 'latex')
    ylabel('Stability Margin [m]', 'Interpreter', 'latex');
elseif scenarioIndex == 2
    title('Top Contact (Pushing Down)', 'Interpreter', 'latex')
    legend({"Without Retargeting", "Posture Retargeting", "Contact Retargeting", "Posture + Contact Retargeting"}, 'Location', 'southwest', 'Orientation', 'vertical', 'Interpreter', 'latex', 'FontSize', 10)
else
    title('Back Contact (Pulling Back)', 'Interpreter', 'latex')
end

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

% disp(ax.Units);

end

function [margin, t] = loadFile(scenarioIndex, ablationIndex)
    rootDirName = 'C:\Users\smccrory\Documents\Simulation Data\';

    if scenarioIndex == 1
        dirName = 'wall0_pitched\';
    elseif scenarioIndex == 2
        dirName = 'wall_top4\';
    else
        dirName = 'wall_back2\';
    end

    if ablationIndex == 1
        ablationDir = 'baseline\';
    elseif ablationIndex == 2
        ablationDir = 'posture\';
    elseif ablationIndex == 3
        ablationDir = 'contact\';
    else
        ablationDir = 'posture_contact\';
    end

    load(strcat(rootDirName, dirName, ablationDir, 'data.scs2.mat'));

    margin = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t = root.('time[sec]');
    a = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
    
    minIndex = getMinIndex(margin, 0.0);
    maxIndex = getMaxIndex(margin, 0.0);

    margin = margin(minIndex:maxIndex);
    t = t(minIndex:maxIndex);
    t = t - t(1);
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
