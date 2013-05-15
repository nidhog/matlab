function [ ] = writeTifs(tifSet, outDir, filenames)
%WRITETIFS Summary of this function goes here
%   Detailed explanation goes here
if ~exist(outDir,'dir')
    mkdir(outDir);
end

%delete any tifs sitting in this dir
files = dir(outDir);
for i=1:length(files)
    if strendswith(files(i).name,'.tif')
        delete([outDir, '/', files(i).name]);        
    end
end

[x y z] = size(tifSet);
for i=1:z
    filename = [outDir, '/', filenames{i}];
    imwrite(uint16(squeeze(tifSet(:,:,i))),filename,'tif');
end
