m_N = [ 0.1903735  0.1691718  0.1443250  0.0972405  0.0593305  0.0892196  0.0893359  0.1130615  0.1347018  0.0985397  0.0734475  0.0553075  0.0495067  0.0465462  0.0448863  0.0423588  0.1858886  0.1318696  0.1154631  0.0877665  0.0737631  0.0864501  0.0915274  0.0830391]';
p_N = [0.1501953125 0.125 0.125 0.066015625 0.060156249999999994 0.07695312500000001 0.06757812500000002 0.0998046875 0.15078125000000003 0.08203125000000001 0.08125000000000002 0.03710937500000001 0.035937500000000004 0.030859375 0.0310546875 0.0341796875 0.12857791739425092 0.0919396421398759 0.05557802872608585 0.02070062551872187 0.019032110477383776 0.025460660773058044 0.049155000000000004 0.076927575]';

m_RT = [ 0.1925511  0.1857484  0.1645411  0.1364970  0.1132073  0.1235603  0.1307066  0.1575484  0.1244710  0.0963056  0.1143329  0.1126547  0.1074225  0.0739198  0.0622588  0.0639125 0.2130449  0.2233028  0.1862107  0.1625751  0.1587249  0.1562878  0.1581955  0.1664873]';
p_RT = [0.17500000000000002 0.1337890625 0.0953125 0.0955078125 0.0947265625 0.09511718749999999 0.09375 0.0990234375 0.08261718750000001 0.08046875000000002 0.0998046875 0.0966796875 0.08750000000000001 0.055859375 0.056054687500000006 0.07480468750000001 0.16893669564372188 0.1553624662429749 0.09813865295740279 0.0961350412429749 0.09330488807927204 0.07126953360108584 0.060850853418077853 0.11233699855665583]';

icpToImpulse = 321.696;
p_N = p_N * icpToImpulse;
p_RT = p_RT * icpToImpulse;

fig = figure;

colorN = [0 0.4470 0.7410];
colorRT = [0.8500 0.3250 0.0980];

scatter(m_N, p_N, 'filled', 'Marker', 'o');
hold on
scatter(m_RT, p_RT, 'filled', 'Marker', 'square');
hold on

xData = [m_N' m_RT']';
yData = [p_N' p_RT']';
% 
% scatter(xData, yData, 'filled', 'Marker', 'o');
% hl = lsline;
% B = [ones(size(xData(:))), xData(:)]\yData(:);
% Slope = B(2)
% Intercept = B(1)


% Fit a polynomial p of degree "degree" to the (x,y) data:
degree = 1;
p = polyfit(xData,yData,degree);
% Evaluate the fitted polynomial p and plot:
f = polyval(p,xData);
eqn = poly_equation(flip(p)); % polynomial equation (string)
Rsquared = my_Rsquared_coeff(yData,f); % correlation coefficient

function Rsquared = my_Rsquared_coeff(data,data_fit)
    % R2 correlation coefficient computation
    
    % The total sum of squares
    sum_of_squares = sum((data-mean(data)).^2);
    
    % The sum of squares of residuals, also called the residual sum of squares:
    sum_of_squares_of_residuals = sum((data-data_fit).^2);
    
    % definition of the coefficient of correlation is
    Rsquared = 1 - sum_of_squares_of_residuals/sum_of_squares; 
end

function eqn = poly_equation(a_hat)
eqn = " y = "+a_hat(1);
for i = 2:(length(a_hat))
    
    if sign(a_hat(i))>0
        str = " + ";
    else
        str = " ";
    end
    
    if i == 2
%         eqn = eqn+" + "+a_hat(i)+"*x";
        eqn = eqn+str+a_hat(i)+"*x";
        
    else
%         eqn = eqn+" + "+a_hat(i)+"*x^"+(i-1)+" ";
        eqn = eqn+str+a_hat(i)+"*x^"+(i-1)+" ";
    end
end
eqn = eqn+" ";
end


mMax = 0.2;
pMax = 0.2 * icpToImpulse;
lineWidth = 3.0;

m_avg_N  = mean(m_N);
m_avg_RT = mean(m_RT);
line([m_avg_N m_avg_N], [0.0 pMax], 'LineWidth', lineWidth * 0.6, 'Color', colorN, 'LineStyle', '-');
line([m_avg_RT m_avg_RT], [0.0 pMax], 'LineWidth', lineWidth * 0.6, 'Color', colorRT, 'LineStyle', '--');

% Predicted LIPM
line([0.0 0.2], [0.0 0.2*icpToImpulse], 'LineWidth', lineWidth * 0.5, 'Color', [0.9290 0.6940 0.1250], 'LineStyle', ':');
% Least-squares regression
line([0.0 0.2], [1.86 (213.9*0.2+1.86)], 'LineWidth', lineWidth * 0.3, 'Color', [0.4940 0.1840 0.5560], 'LineStyle', '-.');

p_avg_N  = mean(p_N);
p_avg_RT = mean(p_RT);
line([0.0 mMax], [p_avg_N p_avg_N], 'LineWidth', lineWidth * 0.6, 'Color', colorN, 'LineStyle', '-');
line([0.0 mMax], [p_avg_RT p_avg_RT], 'LineWidth', lineWidth * 0.6, 'Color', colorRT, 'LineStyle', '--');

disp(p_avg_N);
disp(p_avg_RT);
p_increase = (p_avg_RT - p_avg_N) / p_avg_N;
disp(p_increase);

grid minor

ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.FontSize = 12;

title('Maximum Sustainable Impulsive Disturbance', 'Interpreter', 'latex')

xlim([0 mMax])
ylim([0 60])

legend({"Without Retargeting", "With Retargeting", "Without Retargeting (avg)", "With Retargeting (avg)", "LIPM Model", "Regression"}, 'Location', 'northwest', 'Orientation', 'vertical', 'Interpreter', 'latex', 'FontSize', 10)

xlabel('Stabilty Margin [m]', 'Interpreter', 'latex');
ylabel('Impulsive Disturbance [N$\cdot$s]', 'Interpreter', 'latex');

% lsline
hold off
