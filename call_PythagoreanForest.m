
function  call_PythagoreanForest()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Name - call_PythagoreanForest()
% Creation Date - 25th May 2020
% Author - C. M. Belanger Nzakimuena
%
% Description - Function to load data and call Pythagorean Forest functions
%
% Parameters -
%	Input
%
%	Output
%               Pythagorean Forest single tree visualisation
%               Pythagorean Forest nine trees visualisation
%
% Example -
%		call_PythagoreanForest()
%
% Acknowledgements -
%           Dedicated to the PolyCortex technical society.
%
% License - MIT
%
% Change History -
%                   25th May 2020 - Creation by C. M. Belanger Nzakimuena
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% *add folders containing the libraries used*

addpath(genpath('./subFunctions'))

%% *random forest model files path*

currentFolder = pwd;
% RF model will be stored within the folder at the location specified by
% the path below
if ~exist(fullfile(currentFolder, 'subFunctions', 'globalFolder'), 'dir')
    mkdir(fullfile(currentFolder, 'subFunctions', 'globalFolder'));
end
globalFolder = fullfile(currentFolder, 'subFunctions', 'globalFolder');

% cross-validation model performance results are exported to the folder
% at the location specified by the path below
if ~exist(fullfile(currentFolder, 'resultsFolder'), 'dir')
    mkdir(fullfile(currentFolder, 'resultsFolder'));
end
resultsFolder = fullfile(currentFolder, 'resultsFolder');

%% *input data*

load fisheriris

% 'X' represents the numeric matrix of training data, with features for each
% observation in the form :
% [(petal length) (petal width) (sepal length) (sepal width)]
X = meas;

% 'Y' represents the class corresponding to each observation
Y = species;

%% *model training*

% convert Y into numerical array (required as input to extra trees model)
strY = string(Y);
[~,~,numY] = unique(strY);
cellY = cellstr(num2str(numY));

% 'treesCount' is the number of decision trees for predicting response Y
% as a function X
treesCount = 60;

% Create indices for the k-fold cross-validation
numFolds = 3;
indices = crossvalind('Kfold',Y,numFolds);

% get table row count
rowCount = numFolds+1;
col = zeros(rowCount,1);
colc = cell(rowCount,1);
resultsTable = table(colc,col,col,col,...
    'VariableNames',{'fold' 'recall' 'precision' ...
    'accuracy'});
resultsProfile = zeros(numFolds,3);
tableRow = 0;

precision = zeros(1,max(numY));
recall = zeros(1,max(numY));
for i = 1:numFolds
    test = (indices == i);
    train = ~test;
    
    [BaggedEnsemble, forestData, ~] = generic_random_forests(X(train,:),numY(train,:),treesCount,'classification');
    class = predict(BaggedEnsemble, X(test,:));
    
    % the confusion matrix is generated here for each given 'fold' by
    % comparing 'class' with 'species(test,:)' at each iteration
    confMat = confusionmat(cellY(test,:),class);% ,'order',{'1','2'});
    figure; plotConfMat(confMat.');
    
    subAccuracy = trace(confMat)/sum(confMat(:));
    for ii = 1:size(confMat,1)
        precision(ii)=confMat(ii,ii)/sum(confMat(ii,:));
    end
    precision(isnan(precision))=[];
    subPrecision = sum(precision)/size(confMat,1);
    for iii = 1:size(confMat,1)
        recall(iii)=confMat(iii,iii)/sum(confMat(:,iii));
    end
    recall(isnan(recall))=[];
    subRecall = sum(recall)/size(confMat,1);
    
    resultsProfile(i,:) = [subRecall subPrecision subAccuracy];
    tableRow = tableRow + 1;
    resultsTable{tableRow,'fold'} = {num2str(i)};
    resultsTable{tableRow,'recall'} = subRecall;
    resultsTable{tableRow,'precision'} = subPrecision;
    resultsTable{tableRow,'accuracy'} = subAccuracy;
    
end

resultsTable{rowCount,'fold'} = {'average'};
resultsTable{rowCount,'recall'} = mean(resultsProfile(:,1));
resultsTable{rowCount,'precision'} = mean(resultsProfile(:,2));
resultsTable{rowCount,'accuracy'} = mean(resultsProfile(:,3));

fileName1 = fullfile(resultsFolder,'resultsTable.xls');
writetable(resultsTable,fileName1)

save(fullfile(globalFolder, 'RFmodel.mat'),'BaggedEnsemble','forestData')

%% *Pythagorean forest visualisations*

load(fullfile(globalFolder, 'RFmodel.mat'));

% tree colors selection
%     c1 = rgb('RoyalBlue');
color1 = rgb('LightSkyBlue');
%     c2 = rgb('LimeGreen');
color2 = rgb('DarkGreen');

% single tree visualisation
n = max(forestData{1,1});
M = randomPythagor_tree(n, forestData{1,1}, forestData{1,2}, forestData{1,4}, color1, color2);

% nine trees visualisation
compStruc = cell(9,3);
for i = 1:9
    set(0,'DefaultFigureVisible','off');
    curr_n = max(forestData{i,1});
    curr_M = randomPythagor_tree(curr_n, forestData{i,1}, forestData{i,2}, forestData{i,4}, color1, color2);
    compStruc(i,1) = {curr_M};
    compStruc(i,2) = {curr_n};
    set(0,'DefaultFigureVisible','on');
end
randomPythagor_forest(compStruc, color1, color2)

% model average tree depth calculator (a function of dimensionality)
vecA = zeros(size(forestData, 1),1);
for h = 1:size(forestData, 1)
    vecA(h,1) = max(forestData{h,1});
end
meanTreeDepth = mean(vecA)
% model average lower split fraction calculator (a function of
% dimensionality)
vecB = zeros(size(forestData, 1),1);
for hh = 1:size(forestData, 1)
    propVec = zeros((size(forestData{hh,2},1)-1)/2,1);
    counter = 0;
    for q = 2:2:size(forestData{hh,2},1)
        counter = counter+1;
        frac = forestData{hh,2}(q)/pi*2;
        if frac > 0.5
            frac = 1-frac;
        end
        propVec(counter,1) = frac;
    end
    vecB(h,1) = mean(propVec);
end
meanLowerSplitFraction = mean(vecB)

end
