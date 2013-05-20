addpath('oopsi');

%% load data and run oopsi
cd('data/');
load('fast_smc_vitro12.mat');
cd('..');
F = F{12};
framerate = V.dt;
actualSpikes = V.n;

V = [];
V.dt = framerate;
P = [];
[spikes Pfast Vfast C] = fast_oopsi(F,V,P);

%  find a good threshold for the spikes 
fastThreshold = thresholdSpikes(spikes);

%% display plots

% adjust F to be in the same range as C for nice display
% using standard deviation scaling (makes visual correlation easier)
meanC = mean(C);
stdC = std(C);
F = F - mean(F);
F = F / std(F) * stdC;
F = F + meanC;

% plot
figure(1), clf
T = length(F);
tvec=0:V.dt:(T-1)*V.dt;
h(1)=subplot(411); plot(tvec,F,'k'); axis('tight'), ylabel('F (au)')
h(2)=subplot(412); plot(tvec,actualSpikes,'k'); hold on, axis('tight'), ylabel('voltage')

h(3)=subplot(413); plot(tvec,spikes); hold on, line([0,max(tvec)],[fastThreshold,fastThreshold]), axis('tight'), ylabel('oopsi')
goodSpikesIdx = find(spikes>fastThreshold);
for i=1:length(goodSpikesIdx) %color lines red if they are above threshold
    line([tvec(goodSpikesIdx(i)),tvec(goodSpikesIdx(i))],[0,spikes(goodSpikesIdx(i))], 'Color', 'r');
end

h(4)=subplot(414); plot(tvec,F,'k'); hold on; plot(tvec,C,'g'); axis('tight'), ylabel('C (au)')

xlabel('time (sec)') 


