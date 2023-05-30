% Specify the input AVI video file path
aviFilePath = 'ProximalTransillumination_buccal.avi';

% Read the AVI video
videoReader = VideoReader(aviFilePath);

% Initialize the GIF variables
gifFilePath = 'outputGif.gif';
gifFrameDelay = 0.1; % Delay between frames in seconds

% Create a GIF writer object
gifWriter = VideoWriter(gifFilePath, 'gif', 'DelayTime', gifFrameDelay);
open(gifWriter);

% Read and convert each frame of the AVI video to GIF
while hasFrame(videoReader)
    frame = readFrame(videoReader);
    writeVideo(gifWriter, frame);
end

% Close the GIF writer object
close(gifWriter);

% Display a success message
disp('AVI to GIF conversion completed.');