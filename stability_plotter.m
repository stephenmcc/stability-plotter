% Index for which data set to load, values are 0-2
index = 0;
% Whether to load hardware or simulation data
hardware = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  HARDWARE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if hardware

    %% Data for the paper, collected 11/12 and 12/19
    if index == 0
        % Hip height, no yaw
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241219_BracingTests\20241219_exting_hip0_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241219_BracingTests\20241219_exting_hip0_opt\data.scs2.mat';

    elseif index == 1
        % Knee height, 0 yaw -- good margin
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee0_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee0_opt\data.scs2.mat';

    elseif index == 2
        % Hip height, 45 yaw -- great data
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_133636_Exting_hip_45_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_133636_Exting_hip_45_opt\data.scs2.mat';

    %% Data from 11/05 and 11/12 lower quality or not as good as the above data
    elseif index == 3
        % Hip height, 45 yaw
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_hip0_45_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_hip0_45_opt\data.scs2.mat';

    elseif index == 4
        % Grab bag, no yaw hip height
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\1105 Hardware Testing\20241105_1335_BagGrab0_NoOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\1105 Hardware Testing\20241105_1335_BagGrab0_NoOpt\data.scs2.mat';

    %% Data from Feb 13, replay was not great quality
    elseif index == 5
        % Wall 0, table up
        noOpt = 'C:\Users\smccrory\Documents\250212_BracingTests\Wall0_TableDown_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\250212_BracingTests\Wall0_TableDown_opt\data.scs2.mat';

    elseif index == 6
        % Knee height, 0 yaw
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee_opt\data.scs2.mat';

    elseif index == 7
        % Wall 0, table down
        noOpt = 'C:\Users\smccrory\Documents\250212_BracingTests\Wall0_TableUp_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\250212_BracingTests\Wall0_TableUp_opt\data.scs2.mat';
        
    end

    load(noOpt);
    m0 = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t0 = root.LogDataReader.robotTime;

    load(opt);
    m1 = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t1 = root.LogDataReader.robotTime;  
    stability = root.main.DRCEstimatorThread.NadiaEtherCATRealtimeThread.stabilityState;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  SIMULATION DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else
    if index == 0
        % noOpt = 'C:\Users\smccrory\Documents\Simulation Data\250224_wall0_noOpt\data.scs2.mat';
        % opt_p = 'C:\Users\smccrory\Documents\Simulation Data\250224_wall0_opt_posture2\data.scs2.mat';
        % opt_pc = 'C:\Users\smccrory\Documents\Simulation Data\250224_wall0_opt_pc2_jointFilt_contAdj\data.scs2.mat';

        noOpt_w = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_baseline_weights\data.scs2.mat';
        noOpt = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_baseline\data.scs2.mat';
        opt_p = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_posture\data.scs2.mat';
        opt_c = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_contact\data.scs2.mat';
        opt_pc = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_posture_contact\data.scs2.mat';

        noOpt = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_test_baseline\data.scs2.mat';
        opt_p = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_test_posture_ffHighGainLowClamp\data.scs2.mat';
        opt_c = 'C:\Users\smccrory\Documents\Simulation Data\250308_wall0_test_posture_onlyFF\data.scs2.mat';

    elseif index == 1
        noOpt = 'C:\Users\smccrory\Documents\Simulation Data\250305_wallPitch_noOpt\data.scs2.mat';
        opt_p = 'C:\Users\smccrory\Documents\Simulation Data\250305_wallPitch_opt_posture\data.scs2.mat';
        opt_pc = 'C:\Users\smccrory\Documents\Simulation Data\250305_wallPitch_opt_pc\data.scs2.mat';
    end

    % Load sim data

    load(noOpt_w);
    m0_w = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t0_w = root.('time[sec]');
    a0_w = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
    cx0_w = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.centerOfMassX;
    cy0_w = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.centerOfMassY;

    load(noOpt);
    m0 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t0 = root.('time[sec]');
    a0 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
    cx0 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.centerOfMassX;
    cy0 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.centerOfMassY;

    load(opt_p);
    m1_p = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t1_p = root.('time[sec]');
    stability_p = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerFactory.stabilityState;
    a1_p = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
    cx1 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.centerOfMassX;
    cy1 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.centerOfMassY;

    load(opt_c);
    m1_c = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t1_c = root.('time[sec]');
    stability_c = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerFactory.stabilityState;
    a1_c = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;

    load(opt_pc);
    m1_pc = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t1_pc = root.('time[sec]');
    stability_pc = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerFactory.stabilityState;
    a1_pc = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.stabilityArea;
end

if hardware
    % Crop based on margin
    minIndex0 = getMinIndex(m0, 0.0);
    maxIndex0 = getMaxIndex(m0, 0.0);

    minIndex1 = getMinIndex(m1, 0.0);
    maxIndex1 = getMaxIndex(m1, 0.0);
else
    % Crop based on activation
    minIndex0_w = getMinIndex(m0_w, 0.0);
    maxIndex0_w = getMaxIndex(m0_w, 0.0);

    minIndex0 = getMinIndex(m0, 0.0);
    maxIndex0 = getMaxIndex(m0, 0.0);

    minIndex1_p = getMinIndex(m1_p, 0.0);
    maxIndex1_p = getMaxIndex(m1_p, 0.0);

    minIndex1_c = getMinIndex(m1_c, 0.0);
    maxIndex1_c = getMaxIndex(m1_c, 0.0);

    minIndex1_pc = getMinIndex(m1_pc, 0.0);
    maxIndex1_pc = getMaxIndex(m1_pc, 0.0);
end

% disp(strcat('activation time [sec]:   ', num2str(t1(minIndex1))))
% disp(strcat('deactivation time [sec]: ', num2str(t1(maxIndex1))))

% Crop all data
m0_w = m0_w(minIndex0_w:maxIndex0_w);
t0_w = t0_w(minIndex0_w:maxIndex0_w);
a0_w = a0_w(minIndex0_w:maxIndex0_w);

m0 = m0(minIndex0:maxIndex0);
t0 = t0(minIndex0:maxIndex0);
a0 = a0(minIndex0:maxIndex0);

m1_p = m1_p(minIndex1_p:maxIndex1_p);
t1_p = t1_p(minIndex1_p:maxIndex1_p);
a1_p = a1_p(minIndex1_p:maxIndex1_p);

m1_c = m1_c(minIndex1_c:maxIndex1_c);
t1_c = t1_c(minIndex1_c:maxIndex1_c);
a1_c = a1_c(minIndex1_c:maxIndex1_c);

m1_pc = m1_pc(minIndex1_pc:maxIndex1_pc);
t1_pc = t1_pc(minIndex1_pc:maxIndex1_pc);
a1_pc = a1_pc(minIndex1_pc:maxIndex1_pc);

t0_w = t0_w - t0_w(1);
t0 = t0 - t0(1);
t1_p = t1_p - t1_p(1);
t1_c = t1_c - t1_c(1);
t1_pc = t1_pc - t1_pc(1);

% stability = stability(minIndex1:maxIndex1);

%if ~hardware
%    alpha = alpha(minIndex1:maxIndex1);
%end

% tmin = min(t0(1), t1(1));
% t0 = t0 - tmin;
% t1 = t1 - tmin;

fig = figure;

lineWidth = 2.5;
% p0_w = plot(t0_w, m0_w, 'LineWidth', lineWidth, 'LineStyle', '--', 'Color', 'blue');
% hold on
p0 = plot(t0, m0, 'LineWidth', lineWidth, 'LineStyle', '--', 'Color', 'black');
hold on
p1_p = plot(t1_p, m1_p, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'green');
hold on
p1_c = plot(t1_c, m1_c, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'blue');
hold on
% p1_pc = plot(t1_pc, m1_pc, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'red');
% hold on
ylim([0 max(m0)+0.03])

% lineWidth = 2.5;
% p0 = plot(t0, a0, 'LineWidth', lineWidth, 'LineStyle', '--', 'Color', 'black');
% hold on
% p1_p = plot(t1_p, a1_p, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'green');
% hold on
% p1_pc = plot(t1_pc, a1_pc, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'red');
% hold on
% ylim([0 max(a0)+0.03])

% faceAlpha = 1.0;
% startIndex = 1;
% currentState = stability(1);
% height = 0.25;
% 
% for i = 2:length(stability)
%     if (stability(i) ~= currentState || i == length(stability))
%         endIndex = i;
%         boxT = [t1(startIndex) t1(i) t1(i) t1(startIndex)];
%         boxM = [0 0 height height];
%         patch(boxT, boxM, getColor(currentState), 'FaceAlpha', faceAlpha, 'EdgeAlpha', 0.0);
%         startIndex = i;
%         currentState = stability(i);
%     end
% end
% 
% chH = get(gca,'Children');
% set(gca,'Children',[chH(end);chH(1:end-1)]);
% uistack(p1,'top')

% if ~hardware
%     yyaxis right
%     % plot(t1, alpha, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'black');
%     scatter(t_noOpt, p_noOpt, 'black');
%     scatter(t_opt, p_opt, 'black','filled');
% end

hold off

title('Teleoperated CoM Stability Margin')

% lgd = legend('Nominal', 'Freeze', 'Optimizer', 'With optimized posture', 'With default posture');
%lgd = legend('With default posture', 'With optimized posture');

plts = fig.Children.Children;

lgd = legend([p0 p1_p p1_c],{'With default posture','Opt posture', 'Opt posture ff'});
lgd.Location = 'south';

xlabel('Time [s]')
ylabel('CoM Stability Margin [m]')

% exportgraphics(fig,'StabilityPlot.png','Resolution',1900)

% printMaxDeltaMargin(m0, m1_p, t0, t1_p);
% printAveragePercentageDeltaMargin(m0, m1, t0, t1, stability);

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

function c = getColor(mode)
nominal = [0.8549 1 0.8549];
freeze = [0.90196 0.90196 1];
optimizer = [1 0.8235 0.8235];

if mode == 0
    c = optimizer;
elseif mode == 1
    c = freeze;
    % c = optimizer;
else
    c = nominal;
end
end

function printMaxDeltaMargin(m0, m1_p, t0, t1_p)
maxDelta = 0.0;
maxDeltaIndex = -1;

for i = 1:length(m0)
    if (i <= length(m1))
        candidateDelta = abs(m0(i) - m1(i));
        if (candidateDelta > maxDelta)
            maxDelta = candidateDelta;
            maxDeltaIndex = i;
        end
    end
end

disp(strcat('time of max margin delta: ', num2str(t0(maxDeltaIndex))))
disp(strcat('margin 0: ', num2str(m0(maxDeltaIndex))))
disp(strcat('margin 1: ', num2str(m1(maxDeltaIndex))))
disp(strcat('percentage delta: ', num2str(percentageDelta(m0(maxDeltaIndex), m1(maxDeltaIndex)))))

end

% 0=noOpt, 1=opt
function printAveragePercentageDeltaMargin(m0, m1, t0, t1, stability)

sumPercentage = 0.0;
n = 0;

for i = 1:length(m0)
    if (i <= length(m1) && stability(i) ~= 2)
        sumPercentage = sumPercentage + percentageDelta(m0(i), m1(i));
        n = n + 1;
    end
end

disp(strcat('average percentage delta margin: ', num2str(sumPercentage / n)))

end

function p = percentageDelta(m0, m1)
p = (m1 - m0) / m0;
end
