addpath TpBiometry/Matlab

% Irina MOSCHINI %
%%% Exercice 1: Building the eigenspace %%%

%%% Part A %%%
images_trainA = loadImagesInDirectory('TpBiometry/Images/train_A/');
[MeansA, SpaceA, EigenvaluesA] = buildSpace(images_trainA);
save('MeansA', 'MeansA');
save('SpaceA', 'SpaceA');
save('EigenvaluesA', 'EigenvaluesA');

% The maximum size of the eigenspace is given by the total number of 
% eigenvectors, that is to say 100.

% The more the eigenvalue is large, the more the associated eigenvector
% has an impact on the average image, that is to say it carries a lot of
% information about the pictures of the training set. 


%%% Part B %%%
Y = cumsum(EigenvaluesA);
bar(1:length(Y), Y);

% We can see that the cumulative sum of eigenvalues grows very quickly at
% the beginning, and then increases but more slowly: some eigenvectors 
% carry a lot of information, others almost nothing.. 



%%% Part C %%%
for i = 1 : 10
    FigureHandle = approximateImage('TpBiometry/Images/train_A/s1_1.jpg', MeansA, SpaceA, i*10);
end

% Yes, we can rebuilt the face of the men perfectly. With 50 eigenfaces
% or more, the men is totally recognizable. Having more than 50 eigenfaces 
% doesn't influence a lot the reconstructed image. With 100 eigenfaces, the
% resulting image is exactly the same as the input one. 
% It is normal as we used the images of this men to train the model,that is 
% why we can rebuilt the picture
% perfectly.



%%% Part D %%%

projected_spaceA_trainA = projectImages(images_trainA, MeansA, SpaceA);
save('projected_spaceA_trainA', 'projected_spaceA_trainA')
FigureHandle = plotFirst3Coordinates(projected_spaceA_trainA(1:25,:), 5, 5);

% The figure displayed by the function plotFirst3Coordinates shows that for
% each image, the projection on the first three eigenfaces has
% approximatively the same coordinates. We can thus associate each
% indivicual to a region of the 3D space.
% Thus, given a new image of one of these 5 individuals, projecting it
% on the three first eigenfaces allows to identify the individual by  
% computing the distance from the point obtained to the other points 
% for example. 
