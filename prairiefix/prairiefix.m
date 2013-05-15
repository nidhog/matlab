function [] = prairiefix(inDir, outDir)
brokenData = readTifs(inDir);
img = mean(brokenData,3);
[width height] = size(img);

%scan horizontally (the split line will be vertical)
worstCorrH = 1;
worstCorrIndexH = 0;
for i=1:width-1
    vec1 = double(img(:,i));
    vec2 = double(img(:,i+1));    
    val = corr(vec1,vec2);
    if val < worstCorrH
        worstCorrH = val;
        worstCorrIndexH = i;
    end
end

%scan vertically (the split line will be horizontal)
worstCorrV = 1;
worstCorrIndexV = 0;
for i=1:width-1
    vec1 = double(img(i,:));
    vec2 = double(img(i+1,:));    
    val = corr(vec1',vec2');
    if val < worstCorrV
        worstCorrV = val;
        worstCorrIndexV = i;
    end
end

%generate fixed images
fixedData = zeros(size(brokenData));
newImg = zeros(size(img));
if worstCorrH < worstCorrV
    for z=1:size(brokenData,3)
        newImg(:,1:(height-worstCorrIndexH+1)) = brokenData(:,worstCorrIndexH:height,z);
        newImg(:,(height-worstCorrIndexH+2):height) = brokenData(:,1:worstCorrIndexH-1,z);
        img(:,worstCorrIndexH) = max(max(img));
        fixedData(:,:,z) = newImg;
    end
else
    for z=1:size(brokenData,3)
        newImg(1:(width-worstCorrIndexV+1),:) = brokenData(worstCorrIndexV:width,:,z);
        newImg((width-worstCorrIndexV+2):width,:) = brokenData(1:worstCorrIndexV-1,:,z);
        img(worstCorrIndexV,:) = max(max(img));
        fixedData(:,:,z) = newImg;
    end
end

files = dir(inDir);
tifFilenames = {};
filenameIndex = 1;
for i=1:length(files)
    if strendswith(files(i).name,'.tif')
        tifFilenames{filenameIndex} = files(i).name;
        filenameIndex = filenameIndex+1;
    end
end

writeTifs(fixedData, outDir, tifFilenames);