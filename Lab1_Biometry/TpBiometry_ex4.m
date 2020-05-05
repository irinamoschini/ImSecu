addpath TpBiometry/Matlab

% Irina MOSCHINI %
%%% Exercice 4: mismatch between the eigenspace and test individuals %%%

load('MeansA', 'MeansA');
load('SpaceA', 'SpaceA');
load('EigenvaluesA', 'EigenvaluesA');

%%% Part A %%%

% Projecting images of train_B and test_B on space A and display
images_trainB = loadImagesInDirectory('TpBiometry/Images/train_B/');
images_testB = loadImagesInDirectory('TpBiometry/Images/test_B/');

projected_spaceA_trainB = projectImages(images_trainB, MeansA, SpaceA);
projected_spaceA_testB = projectImages(images_testB, MeansA, SpaceA);

%FigureHandle_spaceA_testB = plotFirst3Coordinates(projected_spaceA_testB(1:25,:), 5, 5);


% Computing the identification rate between train_B and test_B based on the
% projection of all images on space A

proj_mean_trainB_spaceA = mean(projected_spaceA_trainB(1:5,:));
for individual = 2 : 20
    new_indiv = mean(projected_spaceA_trainB((individual-1)*5+1 : individual*5, :));
    proj_mean_trainB_spaceA = [proj_mean_trainB_spaceA; new_indiv];
end

IdentificationRates = ones(100, 1);
NumberEigenfaces = ones(100, 1);
for i = 1 : 100
    i
    NumberEigenfaces(i, 1) = i;
    IdentificationRate = identify(proj_mean_trainB_spaceA, projected_spaceA_testB, i, 1)
    IdentificationRates(i, 1) = IdentificationRate;
end

%figure;
%plot(NumberEigenfaces, IdentificationRates, 'c*')


% The results are not that bad. The best indentification rate is 85%
% obtained with 84 or more eigenfaces. However, using 45 eigenvectors
% allows to have 84% of identification. 
% We should use 45 eigenvectors to have good results, but will need 84
% eigenvectors to have the optimal identification rate of 85%.





%%% Part B %%%
[MeansB, SpaceB, EigenvaluesB] = buildSpace(images_trainB);
projected_spaceB_trainB = projectImages(images_trainB, MeansB, SpaceB);
projected_spaceB_testB = projectImages(images_testB, MeansB, SpaceB);
%FigureHandle_spaceB_testB = plotFirst3Coordinates(projected_spaceB_testB(1:25,:), 5, 5);


proj_mean_trainB = mean(projected_spaceB_trainB(1:5,:));
for individual = 2 : 20
    new_indiv = mean(projected_spaceB_trainB((individual-1)*5+1 : individual*5, :));
    proj_mean_trainB = [proj_mean_trainB; new_indiv];
end

IdentificationRates_spaceB = ones(100, 1);
NumberEigenfaces_spaceB = ones(100, 1);
for i = 1 : 100
    i
    NumberEigenfaces_spaceB(i, 1) = i;
    IdentificationRate_spaceB = identify(proj_mean_trainB, projected_spaceB_testB, i, 1)
    IdentificationRates_spaceB(i, 1) = IdentificationRate_spaceB;
end

%figure;
plot(NumberEigenfaces_spaceB, IdentificationRates_spaceB, 'c*')

% The best results are obtained with 48 eigenfaces, that gives 89% of
% identification. It is better than the results obtained with projection on
% space A (85%), but not extremly better, the difference is not
% significant. Thus, projecting on a space on which the training has not
% been done with the individuals that belongs to the testing can be done:
% results are similar.

% There are some advantages to have the same individuals in the training
% and testing sets, but also drawbacks: 
%      - advantages: the results are a bit better than using a training set
% with other individuals than the ones in the testing set
%      - drawbacks: we need to know and enroll all the suspects in the 
% training set, which would take a lot of time and space. We would need to 
% update all the time the training set if new people arrive, or if some 
% leave. 





