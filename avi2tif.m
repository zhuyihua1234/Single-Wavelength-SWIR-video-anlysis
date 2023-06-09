% This program converts AVI video into individual TIF frames
% Instructions:
    % Run the program inside the folder that contains your AVI videos
    % Select the video you want to convert
    % Select the folder you wish to save the video to


file = uigetfile('*.avi');
[pathstr,name,ext] = fileparts(file);
% Create new folder that contains TIF frames
mkdir(name);
outputFolder = uigetdir(path);
%%
% Initiate conversion
obj = VideoReader(file);
vid = read(obj);
frames = obj.NumberOfFrames;
for x = 1 : frames
    outputBaseFileName = sprintf('Frame %4.4d.tif', x);
    outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    imwrite(vid(:,:,:,x), outputFullFileName, 'tif');
end