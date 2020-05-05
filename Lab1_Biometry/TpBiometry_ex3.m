addpath TpBiometry/Matlab

% Irina MOSCHINI %
%%% Exercice 3: verification %%%

%%% Part A %%%
load('proj_mean_trainA', 'proj_mean_trainA')
load('projected_spaceA_testA', 'projected_spaceA_testA')

[DistancesClients, DistancesImpostors] = verify(proj_mean_trainA, projected_spaceA_testA, 5);
[YClients XClients] = hist(-log(DistancesClients), 10);
[YImpostors XImpostors] = hist(-log(DistancesImpostors), 10);
figure;
plot(XClients, YClients, 'b', XImpostors, (YImpostors / 19), 'r');


% We can see thanks to the plot that the distance for a client can be as
% high as the distance for an impostor : the curves representing the
% distance of clients and impostors overlap (in the interval 
% [-14.5;-12]). Thus, some people can be hard to categorize and
% mistakes can be made in this overlapping area. The decision threshold
% need to be addapted to minimize the False Acceptance Rate but also the
% False Rejection Rate at the same time (avoid rejecting everybody). 



%%% Part B %%%
[FalseRejectionRates, FalseAcceptanceRates] = computeVerificationRates (DistancesClients, DistancesImpostors);
figure;
plot(FalseAcceptanceRates, FalseRejectionRates, 'c*')

% We can see thanks to the plot that the False Acceptance Rate is very very
% small for a huge number of decision thresholds: it is smaller than 5% for 
% 85 thresholds over 101. Thus, this technology can be very useful if the 
% security has to be very high and want a impostor rate near 0% (even if 
% the rejection rate, that mean the clients that we reject, is high).

% The False Rejection Rate is therefore quite high, but
% some decision thresholds allow to have small FAR AND FRR.
% The best threshorld we can keep is the one that gives a FAR = 9,63% and 
% FRR = 8,00%.


%%% Part C %%%
NumberEigenfaces = ones(100, 1);
ERRs = ones(100, 1);

for eigenfaces = 1 : 100
    NumberEigenfaces(eigenfaces) = eigenfaces;
    [DistancesClients, DistancesImpostors] = verify(proj_mean_trainA, projected_spaceA_testA, eigenfaces);
    EqualErrorRate = computeEER(DistancesClients, DistancesImpostors);
    ERRs(eigenfaces) = EqualErrorRate; 
end

figure;
plot(NumberEigenfaces, ERRs, 'c*')

% We want the smallest value of Equal Error Rate to have good performances
% both on FAR and FRR.
% We can see thanks to the plot that the ERR is quite high while using a
% very small number of eigenfaces, but very good results are obtained with 
% more eigenfaces. The best rate we get is obtained with 23 eigenfaces, 
% with an ERR = 4,950%. However, an interesting result is the one obtained
% with 16 eigenfaces, that gives an ERR of 5,00%. Doing only 5% of FAR and
% FRR is fair: the system is reliable.