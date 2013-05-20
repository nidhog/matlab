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
Pfast

V.smc_iter_max = 1;
M.nbar = zeros(length(F),1);
M.nbar(1) = 1;

%  find a good threshold for the spikes 
fastThreshold = theo_thresholdSpikes(spikes);
smcThreshold = theo_thresholdSpikes(M.nbar);


%% display plots of oopsi outputs

C = C + 1.5; %shift up a bit for nice plotting

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
h(1)=subplot(311); plot(tvec,F,'k'); axis('tight'), ylabel('F (au)')
h(2)=subplot(312); plot(tvec,actualSpikes,'k'); hold on, axis('tight'), ylabel('voltage')

h(3)=subplot(313); plot(tvec,spikes); hold on, line([0,max(tvec)],[fastThreshold,fastThreshold]), axis('tight'), ylabel('oopsi')
goodSpikesIdx = find(spikes>fastThreshold);
for i=1:length(goodSpikesIdx) %color lines red if they are above threshold
    line([tvec(goodSpikesIdx(i)),tvec(goodSpikesIdx(i))],[0,spikes(goodSpikesIdx(i))], 'Color', 'r');
end


xlabel('time (sec)') 


