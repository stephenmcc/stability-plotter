% Index for which data set to load, values are 0-2
index = -1;
% Whether to load hardware or simulation data
hardware = false;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  HARDWARE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if hardware

    if index == 0
        % Hip height, no yaw
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241219_BracingTests\20241219_exting_hip0_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241219_BracingTests\20241219_exting_hip0_opt\data.scs2.mat';

    elseif index == 1
        % Hip height, 45 yaw
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_hip0_45_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_hip0_45_opt\data.scs2.mat';

    elseif index == 2
        % Knee height, 0 yaw
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee_opt\data.scs2.mat';

    elseif index == 3
        % Knee height, 0 yaw -- good margin
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee0_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_122622_Exting_knee0_opt\data.scs2.mat';

    elseif index == 4
        % Hip height, 45 yaw -- best data
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_133636_Exting_hip_45_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\241112_BracingTests\20241112_133636_Exting_hip_45_opt\data.scs2.mat';

    else
        % Grab bag, no yaw hip height
        noOpt = 'C:\Users\smccrory\Documents\Support Region Optimization\1105 Hardware Testing\20241105_1335_BagGrab0_NoOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Support Region Optimization\1105 Hardware Testing\20241105_1335_BagGrab0_NoOpt\data.scs2.mat';
    end

    load(noOpt);
    m0 = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t0 = root.LogDataReader.robotTime;

    load(opt);
    m1 = root.main.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t1 = root.LogDataReader.robotTime;  
    % stability = root.main.DRCEstimatorThread.NadiaEtherCATRealtimeThread.stabilityState;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  SIMULATION DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else
    if index == -1
        noOpt = 'C:\Users\smccrory\Documents\Simulation Data\250211_wall0_noOpt\data.scs2.mat';
        opt = 'C:\Users\smccrory\Documents\Simulation Data\250211_wall0_opt\data.scs2.mat';

    % 0 pitch
    elseif index == 0
        noOpt = 'C:\Users\smccrory\.ihmc\logs\multi-contact\wall0_noOpt\simData\data.scs2.mat';
        opt = 'C:\Users\smccrory\.ihmc\logs\multi-contact\wall0_opt\simData\data.scs2.mat';

        t_noOpt = [8.5371 8.940000000000001 9.3429 9.7458 10.148700000000002 10.5516 10.9545 11.3574 11.7603 12.1632 12.5661 ]';
        m_noOpt = [ 0.1262829  0.0962491  0.0668313  0.0559171  0.0493822  0.0484108  0.0495685  0.0713597  0.1061030  0.1524502  0.1867267 ]';
        p_noOpt = [0.08359375000000001 0.05048828125 0.03564453125000001 0.023730468749999997 0.02294921875 0.023730468749999997 0.028710937500000002 0.06083984375 0.0970703125 0.107421875 0.15468750000000003 ]';

        t_opt = [8.5371 8.940000000000001 9.3429 9.7458 10.148700000000002 10.5516 10.9545 11.3574 11.7603 12.1632 12.5661 ]';
        m_opt = [ 0.1224808  0.1008348  0.1004655  0.1095591  0.1127750  0.1147841  0.1206347  0.1547940  0.1866927  0.1881925  0.1743565 ]';
        p_opt = [0.08964843750000001 0.06923828125 0.09296875 0.09560546875 0.09375 0.08710937500000002 0.08125000000000002 0.10419921875000002 0.15615234375000003 0.15771484375000003 0.1265625 ]';

        % Pitched
    elseif index == 1
        noOpt = 'C:\Users\smccrory\.ihmc\logs\multi-contact\wallPitched_noOpt\simData\data.scs2.mat';
        opt = 'C:\Users\smccrory\.ihmc\logs\multi-contact\wallPitched_opt\simData\data.scs2.mat';

        t_noOpt = [9.773 10.2059 10.6388 11.0717 11.5046 11.9375 12.3704 12.8033 13.2362 13.6691 14.102 ]';
        m_noOpt = [ 0.1045327  0.0807689  0.0704534  0.0671853  0.0652363  0.0589226  0.0610855  0.0790487  0.1031842  0.1361256  0.1529819 ]';
        p_noOpt = [0.08876953125 0.06962890625000001 0.06376953124999998 0.061328125 0.05625 0.05380859375 0.06044921875 0.08652343750000001 0.109765625 0.116796875 0.0978515625 ]';

        t_opt = [9.773 10.2059 10.6388 11.0717 11.5046 11.9375 12.3704 12.8033 13.2362 13.6691 14.102 ]';
        m_opt = [ 0.1079478  0.0959492  0.0932760  0.0924456  0.0928128  0.0906549  0.0899210  0.1020501  0.1241107  0.1487322  0.1678571 ]';
        p_opt = [0.09882812500000002 0.09228515625 0.0958984375 0.09716796875 0.095703125 0.09345703124999999 0.08369140625000002 0.09765625 0.108984375 0.1251953125 0.13720703125 ]';

        % Uneven
    else
        noOpt = 'C:\Users\smccrory\.ihmc\logs\multi-contact\wallUneven_noOpt\simData\data.scs2.mat';
        opt = 'C:\Users\smccrory\.ihmc\logs\multi-contact\wallUneven_opt\simData\data.scs2.mat';

        t_noOpt = [9.713 10.1444 10.5758 11.0072 11.4386 11.87 12.3014 12.7328 13.1642 13.5956 14.027 ]';
        m_noOpt = [ 0.1129537  0.0926445  0.0868736  0.0750378  0.0636270  0.0446326  0.0470888  0.0628011  0.1000120  0.1415180  0.1754705 ]';
        p_noOpt = [0.08623046875000001 0.06865234375000001 0.0640625 0.0498046875 0.045800781250000006 0.034765625 0.04023437500000001 0.068359375 0.07890625000000001 0.10078125 0.10791015625 ]';

        t_opt = [9.713 10.1444 10.5758 11.0072 11.4386 11.87 12.3014 12.7328 13.1642 13.5956 14.027 ]';
        m_opt = [ 0.1166213  0.0942087  0.0891942  0.0846237  0.0820293  0.0756050  0.0767767  0.0937320  0.1364969  0.1633428  0.1806291 ]';
        p_opt = [0.08203125000000001 0.06533203125 0.06005859374999999 0.05673828125 0.058984375 0.054101562500000006 0.0576171875 0.08105468750000001 0.085546875 0.09824218750000001 0.12363281250000001 ]';
    end

    % Load sim data

    load(noOpt);
    m0 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t0 = root.('time[sec]');

    load(opt);
    m1 = root.nadia.DRCSimulation.DRCControllerThread.DRCMomentumBasedController.HumanoidHighLevelControllerManager.HighLevelHumanoidControllerToolbox.cop_StabilityMarginRegionCalculator.cop_StabilityMargin;
    t1 = root.('time[sec]');

end

if hardware
    % Crop based on margin
    minIndex0 = getMinIndex(m0, 0.0);
    maxIndex0 = getMaxIndex(m0, 0.0);

    minIndex1 = getMinIndex(m1, 0.0);
    maxIndex1 = getMaxIndex(m1, 0.0);
else
    % Crop based on activation
    minIndex1 = getMinIndex(m1, 0.0);
    maxIndex1 = getMaxIndex(m1, 0.0);

    minIndex0 = minIndex1;
    maxIndex0 = maxIndex1;
end

disp(strcat('activation time [sec]:   ', num2str(t1(minIndex1))))
disp(strcat('deactivation time [sec]: ', num2str(t1(maxIndex1))))

% Crop all data
m0 = m0(minIndex0:maxIndex0);
t0 = t0(minIndex0:maxIndex0);
m1 = m1(minIndex1:maxIndex1);
t1 = t1(minIndex1:maxIndex1);
% stability = stability(minIndex1:maxIndex1);

%if ~hardware
%    alpha = alpha(minIndex1:maxIndex1);
%end

% tmin = min(t0(1), t1(1));
% t0 = t0 - tmin;
% t1 = t1 - tmin;

fig = figure;

lineWidth = 2.5;
p0 = plot(t0, m0, 'LineWidth', lineWidth, 'LineStyle', '--', 'Color', 'black');
hold on
p1 = plot(t1, m1, 'LineWidth', lineWidth, 'LineStyle', '-', 'Color', 'black');
hold on
ylim([0 max(m0)+0.03])

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

if ~hardware
    yyaxis right
    % plot(t1, alpha, 'LineWidth', lineWidth, 'LineStyle', '-.', 'Color', 'black');
    scatter(t_noOpt, p_noOpt, 'black');
    scatter(t_opt, p_opt, 'black','filled');
end

hold off

title('Teleoperated CoM Stability Margin')

% lgd = legend('Nominal', 'Freeze', 'Optimizer', 'With optimized posture', 'With default posture');
%lgd = legend('With default posture', 'With optimized posture');

plts = fig.Children.Children;

lgd = legend([p0 p1 plts(3) plts(4)],{'With default posture','With optimized posture','Nominal Posture', 'Optimized Posture'});
lgd.Location = 'south';

xlabel('Time [s]')
ylabel('CoM Stability Margin [m]')

% exportgraphics(fig,'StabilityPlot.png','Resolution',1900)

printMaxDeltaMargin(m0, m1, t0, t1);
printAveragePercentageDeltaMargin(m0, m1, t0, t1, stability);

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

function printMaxDeltaMargin(m0, m1, t0, t1)
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
