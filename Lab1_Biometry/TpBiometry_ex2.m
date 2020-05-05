addpath TpBiometry/Matlab

% Irina MOSCHINI %
%%% Exercice 2: identification %%%

%%% Part A %%%
load('MeansA', 'MeansA');
load('SpaceA', 'SpaceA');
load('EigenvaluesA', 'EigenvaluesA');

images_testA = loadImagesInDirectory('TpBiometry/Images/test_A/');
projected_spaceA_testA = projectImages(images_testA, MeansA, SpaceA);
save('projected_spaceA_testA', 'projected_spaceA_testA')

figure;
FigureHandle_testA = plotFirst3Coordinates(projected_spaceA_testA(1:25,:), 5, 5);

% The classification is harder to do as the images are new, they were not
% used to train the algorithm. 
% Thus, some images are hard to classify and some individuals have similar
% coordinates in the space composed of the three first eigenvectors.


%%% Part B %%%
for i = 1 : 10
    figure;
    FigureHandle = approximateImage('TpBiometry/Images/test_A/s1_6.jpg', MeansA, SpaceA, i*10);
end

% The results are a way different from the ones obtained with an image of
% the training set. In fact, even with 100 eigenvectors, the individual is
% hard to recognize: we can't rebuild it perfectly. 
% It is normal as this picture is not present in the training set, thus
% the caracteristics have not been learnt by the algorithm (the eigenspace 
% is not adapted to his face).


%%% Part C %%%
load('projected_spaceA_trainA', 'projected_spaceA_trainA')

proj_trainA = projected_spaceA_trainA(1,:);
for individual = 2 : 20
    new_indiv = projected_spaceA_trainA((individual-1)*5+1,:);
    proj_trainA = [proj_trainA; new_indiv];
end

IdentificationRates = ones(100, 1);
NumberEigenfaces = ones(100, 1);
for i = 1 : 100
    NumberEigenfaces(i, 1) = i;
    IdentificationRate = identify(proj_trainA, projected_spaceA_testA, i, 1);
    IdentificationRates(i, 1) = IdentificationRate;
end

figure;
plot(NumberEigenfaces, IdentificationRates, 'c*')

% Identification (first face)
% We want the higher identification rate as possible. We can see that the
% highest value is reached by using between 35 or 36 eigenfaces. The
% identification rate is thus 77%, which is quite high. 
% The optimal number of eigenfaces to use is therefore 35 (the smallest
% number of eigenfaces that led to the best identification rate).


%%% Part D %%%
proj_mean_trainA = mean(projected_spaceA_trainA(1:5,:));
for individual = 2 : 20
    new_indiv = mean(projected_spaceA_trainA((individual-1)*5+1 : individual*5, :));
    proj_mean_trainA = [proj_mean_trainA; new_indiv];
end
save('proj_mean_trainA', 'proj_mean_trainA')

IdentificationRates_mean = ones(100, 1);
NumberEigenfaces_mean = ones(100, 1);
for i = 1 : 100
    NumberEigenfaces_mean(i, 1) = i;
    IdentificationRate_mean = identify(proj_mean_trainA, projected_spaceA_testA, i, 1);
    IdentificationRates_mean(i, 1) = IdentificationRate_mean;
end

figure;
plot(NumberEigenfaces_mean, IdentificationRates_mean, 'c*')

% Identification (mean face)
% Taking the mean of the coordinates of the image of a same individual is
% very efficient as the maximum identification rate is now 94% compared to
% 77% previously. There are now only 6 picture that are not well
% classified.
% The optimal number of eigenfaces to take here is now 23, which is lower
% than the 35 eigenvectors we needed before. This method (mean face) is 
% therefore a way more efficient than the first one (first face). 
% However, we can point out that all the picture can't be associated, for
% sure, to the right person. 6 persons can't be identified.



% The cumulative identification might be powerful for some applications
% where we NEED to find the individual, even if we have several suspects.
% The police for example might need to find one person in particular and
% don't mind to arrest arrest a lot of people if at the end the find their
% target.
% The probability to find the men we are looking for is therefore bigger 
% with cumulative identification than with "classical" identification.


%%% Part E %%%

IdentificationRates_NBest = ones(20, 1);
NumberSuspects = ones(20, 1);

for NBest = 1 : 20
    NumberSuspects(NBest, 1) = NBest;
    IdentificationRate_NBest = identify(proj_mean_trainA, projected_spaceA_testA, 5, NBest);
    IdentificationRates_NBest(NBest, 1) = IdentificationRate_NBest;
end

figure;
plot(NumberSuspects, IdentificationRates_NBest, 'c*')

% The plot that represents the identification rate as a function of parameter
% NBest shows that using NBest = 8 gives a powerful result: an
% identification rate of 100%, that is to say that if we give the 8
% individuals associated with the best ranks, the "real" men is, for sure,
% one of these 8 men.
% Even using just the 5 individuals associated to the best ranks allows to
% have identification of 99%, that is to say only one mistake has been done
% on our testing set. This is good but some application can't take the risk
% to do one mistake. 
% A last remark is that we used 5 eigenfaces, that gives us, in the part D 
% (mean face), 71% of good identifications which is not a lot compared to 
% the other good results we obtained. Therefore, using more eigenfaces can 
% led to even better result than what we get. 


