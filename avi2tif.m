file = '1.avi'
[pathstr,name,ext] = fileparts(file);
mkdir(name);
outputFolder = uigetdir(path);
%%
obj = VideoReader(file);
vid = read(obj);
frames = obj.NumberOfFrames;
for x = 1 : frames
    outputBaseFileName = sprintf('Frame %4.4d.tif', x);
    outputFullFileName = fullfile(outputFolder, outputBaseFileName);
    imwrite(vid(:,:,:,x), outputFullFileName, 'tif');
end