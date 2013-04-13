% load stimulus and frametime information from txt files for 2p experiment
% uses variable number of input arguments to get 2p frametimes
function [P, S, stimOn, stimID, ST, M] = getTimesXML(ShowFigures, xmlFileName)

    P = load('twophotontimes.txt');
    S = load('stimontimes.txt');
    stimOn = S(2:2:length(S));
    stimID = S(1:2:length(S)-1);
    f1 = fopen('stimtimes.txt', 'r');
    ST = fscanf(f1, '%f');

    if ShowFigures
        figure();
        hold on;
        plot(P, ones(size(P)), 'bo');
        plot(stimOn, 2 * ones(size(stimOn)), 'go');
        xlim([0 200]);
        ylim([0 5]);
    end;
    M = readprairiexml(xmlFileName, 1);
    disp('Loaded stim data, scan frames, scan properties')
