% Extract the columns from the imported table
dates = datetime(Book91.Date, 'InputFormat', 'dd/MM/yyyy'); % Convert strings to 
datetime
values = Book91.Value;
maxValues = Book91.MaxValue;
minValues = Book91.MinValue;
% Convert datetime to numeric for interpolation
numericDates = datenum(dates);
% Check for non-finite values and remove them
finiteIdx = isfinite(numericDates) & isfinite(values) & isfinite(maxValues) & 
isfinite(minValues);
numericDates = numericDates(finiteIdx);
values = values(finiteIdx);
maxValues = maxValues(finiteIdx);
minValues = minValues(finiteIdx);
% Interpolating data to fill gaps if necessary
% Create a full range of dates
fullNumericDates = min(numericDates):max(numericDates);
valuesInterp = interp1(numericDates, values, fullNumericDates, 'linear');
maxValuesInterp = interp1(numericDates, maxValues, fullNumericDates, 'linear');
minValuesInterp = interp1(numericDates, minValues, fullNumericDates, 'linear');
% Convert numeric dates back to datetime
fullDates = datetime(fullNumericDates, 'ConvertFrom', 'datenum');
% Plotting the Time Series
figure;
plot(fullDates, valuesInterp, 'Color', 'b', 'DisplayName', 'Value');
hold on;
plot(fullDates, maxValuesInterp, 'Color', 'r', 'DisplayName', 'Max Value');
plot(fullDates, minValuesInterp, 'Color', 'g', 'DisplayName', 'Min Value');
xlabel('Date');
ylabel('Values');
title('Time Series Plot');
legend('show');
grid on;
hold off;
% Manual calculation of CDF
figure;
[sortedValues, sortIdx] = sort(valuesInterp);
cdfValues = (1:length(sortedValues)) / length(sortedValues);
plot(sortedValues, cdfValues, 'b', 'DisplayName', 'Value');
hold on;
[sortedMaxValues, sortMaxIdx] = sort(maxValuesInterp);
cdfMaxValues = (1:length(sortedMaxValues)) / length(sortedMaxValues);
plot(sortedMaxValues, cdfMaxValues, 'r', 'DisplayName', 'Max Value');
[sortedMinValues, sortMinIdx] = sort(minValuesInterp);
cdfMinValues = (1:length(sortedMinValues)) / length(sortedMinValues);
plot(sortedMinValues, cdfMinValues, 'g', 'DisplayName', 'Min Value');
legend('Value', 'Max Value', 'Min Value');
xlabel('Value');
ylabel('CDF');
title('Cumulative Distribution Function (CDF)');
grid on;
hold off;
% Manual calculation of PDF using histogram
figure;
histogram(valuesInterp, 'Normalization', 'pdf', 'DisplayName', 'Value', 'FaceColor', 
'b');
hold on;
histogram(maxValuesInterp, 'Normalization', 'pdf', 'DisplayName', 'Max Value', 
'FaceColor', 'r');
histogram(minValuesInterp, 'Normalization', 'pdf', 'DisplayName', 'Min Value', 
'FaceColor', 'g');
xlabel('Value');
ylabel('Density');
title('Probability Density Function (PDF)');
legend('show');
grid on;
hold off;
% Calculate Mean, Variance, and Standard Deviation
meanValue = mean(valuesInterp);
meanMaxValue = mean(maxValuesInterp);
meanMinValue = mean(minValuesInterp);
varValue = var(valuesInterp);
varMaxValue = var(maxValuesInterp);
varMinValue = var(minValuesInterp);
stdValue = std(valuesInterp);
stdMaxValue = std(maxValuesInterp);
stdMinValue = std(minValuesInterp);
% Display the calculated statistics
fprintf('Statistics for Value:\n');
fprintf('Mean: %.2f\n', meanValue);
fprintf('Variance: %.2f\n', varValue);
fprintf('Standard Deviation: %.2f\n\n', stdValue);
fprintf('Statistics for Max Value:\n');
fprintf('Mean: %.2f\n', meanMaxValue);
fprintf('Variance: %.2f\n', varMaxValue);
fprintf('Standard Deviation: %.2f\n\n', stdMaxValue);
fprintf('Statistics for Min Value:\n');
fprintf('Mean: %.2f\n', meanMinValue);
fprintf('Variance: %.2f\n', varMinValue);
fprintf('Standard Deviation: %.2f\n', stdMinValue);
% Time series forecasting with linear regression
% Define forecast horizon (3 years)
forecastHorizon = 365 * 3;
% Prepare the regression model
X = (1:length(valuesInterp))';
y = valuesInterp;
mdl = fitlm(X, y);
% Create future dates and indices for prediction
futureX = (length(valuesInterp) + 1 : length(valuesInterp) + forecastHorizon)';
[futureValues, futureCI] = predict(mdl, futureX);
% Create future dates
futureDates = (fullDates(end) + caldays(1:forecastHorizon))';
% Plot forecasted values
figure;
plot(fullDates, valuesInterp, 'b', 'DisplayName', 'Historical Data');
hold on;
plot(futureDates, futureValues, 'r--', 'DisplayName', 'Forecast');
plot(futureDates, futureCI(:,1), 'k--', 'DisplayName', 'Confidence Interval');
plot(futureDates, futureCI(:,2), 'k--', 'HandleVisibility', 'off');
xlabel('Date');
ylabel('Values');
title('Forecasted Time Series');
legend('show');
grid on;
hold off