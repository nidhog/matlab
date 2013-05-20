function [ threshold ] = theo_thresholdSpikes( spikes )
% determines a cutoff for oopsi output to tell which values should be
% considered spikes

% first, discard any extremely low values 
% (say, less than 1/10 of the average of the top 5 values.)
sortedValues = sort(spikes(:),'descend');
epsilon = mean(sortedValues(1:5)) / 10; 
goodSpikes = spikes(find(spikes>epsilon));

%now separate the remaining spikes into two classes, 'junk' and 'good'
idx = otsu(goodSpikes); % gives indices of values above and below threshold

%threshold is between the max of class 1 and the min of class 2
threshold = (min(goodSpikes(find(idx==2))) + max(goodSpikes(find(idx==1))))/2;

% uncomment to plot distribution
%figure,hist(goodSpikes); hold on; title(['threshold: ' num2str(threshold)]);

end

