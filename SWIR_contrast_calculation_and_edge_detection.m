%Import image
file = uigetfile('*.*');
raw_img = imread(file);
grayImage = fliplr(raw_img);

%Draw ROI in imfreehand and get ROI info
fontSize = 16;
imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

% Ask user to draw freehand mask for Lesion ROI.
message = sprintf('Left click and hold to begin drawing lesion ROI.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH = imfreehand(); % Actual line of code to do the drawing.
% Create a binary image ("mask") from the ROI object.
binaryImage = hFH.createMask();
xy = hFH.getPosition;

% Ask user to draw freehand mask for Sound ROI.
message = sprintf('Left click and hold to begin drawing sound ROI.\nSimply lift the mouse button to finish');
uiwait(msgbox(message));
hFH2 = imfreehand(); % Actual line of code to do the drawing.
% Create a binary image ("mask") from the ROI object.
binaryImage2 = hFH2.createMask();
xy2 = hFH2.getPosition;

% Now make it smaller so we can show more images.
subplot(2, 4, 1);
imshow(grayImage, []);
axis on;
drawnow;
title('Original gray scale image', 'FontSize', fontSize);

% Label the binary image and computer the centroid and center of mass.
labeledImage = bwlabel(binaryImage);
measurements = regionprops(binaryImage, grayImage, ...
    'area', 'Centroid', 'WeightedCentroid', 'Perimeter');
area = measurements.Area
centroid = measurements.Centroid
centerOfMass = measurements.WeightedCentroid
perimeter = measurements.Perimeter

% Calculate the area, in pixels, that they drew.
numberOfPixels1 = sum(binaryImage(:))
% Another way to calculate it that takes fractional pixels into account.
numberOfPixels2 = bwarea(binaryImage)

% Get coordinates of the boundary of the freehand drawn region.
structBoundaries = bwboundaries(binaryImage);
xy=structBoundaries{1}; % Get n by 2 array of x,y coordinates.
x = xy(:, 2); % Columns.
y = xy(:, 1); % Rows.
subplot(2, 4, 1); % Plot over original image.
hold on; % Don't blow away the image.
plot(x, y, 'LineWidth', 2);
drawnow; % Force it to draw immediately.

% Burn region as white into image by setting it to 255 wherever the mask is true.
burnedImage = grayImage;
burnedImage(binaryImage) = 255;

% Burn region as black into image by setting it to 255 wherever the mask is true.
burnedImage = grayImage;
burnedImage(binaryImage) = 0;

% Mask the image white outside the mask, and display it.
% Will keep only the part of the image that's inside the mask, white outside mask.
whiteMaskedImage = grayImage;
whiteMaskedImage(~binaryImage) = 255;

% Mask the image outside the mask, and display it.
% Will keep only the part of the image that's inside the mask, zero outside mask.
blackMaskedImage = grayImage;
blackMaskedImage2 = grayImage;
blackMaskedImage(~binaryImage) = 0;
blackMaskedImage2(~binaryImage2) = 0;
% Calculate the means for both lesion and sound
meanGL = mean(blackMaskedImage(binaryImage));
sdGL = std(double(blackMaskedImage(binaryImage)));
meanGL2 = mean(blackMaskedImage2(binaryImage2));
sdGL2 = mean(blackMaskedImage2(binaryImage2));

% Calculate contrast
ref_contrast = (meanGL-meanGL2)/meanGL;
trans_contrast = (meanGL2-meanGL)/meanGL2;

% Now crop the image.
leftColumn = min(x);
rightColumn = max(x);
topLine = min(y);
bottomLine = max(y);
width = rightColumn - leftColumn + 1;
height = bottomLine - topLine + 1;
croppedImage = imcrop(blackMaskedImage, [leftColumn, topLine, width, height]);

% Display images with edge detection algorithm
BW2 = edge(grayImage,'log',0.001);
BW3 = edge(grayImage,'log',0.0012);
BW4 = edge(grayImage,'log',0.0014);
BW5 = edge(grayImage,'log',0.0016);
BW6 = edge(grayImage,'log',0.0018);
BW7 = edge(grayImage,'log',0.0020);
BW8 = edge(grayImage,'log',0.0022);

subplot(2,4,2);
imshow(BW2);
axis on;
title('threshold = 0.001', 'FontSize', fontSize);

subplot(2,4,3);
imshow(BW3);
axis on;
title('threshold = 0.0012', 'FontSize', fontSize);

subplot(2,4,4);
imshow(BW4);
axis on;
title('threshold = 0.0014', 'FontSize', fontSize);

subplot(2,4,5);
imshow(BW5);
axis on;
title('threshold = 0.0016', 'FontSize', fontSize);

subplot(2,4,6);
imshow(BW6);
axis on;
title('threshold = 0.0018', 'FontSize', fontSize);

subplot(2,4,7);
imshow(BW7);
axis on;
title('threshold = 0.0020', 'FontSize', fontSize);

subplot(2,4,8);
imshow(BW8);
axis on;
title('threshold = 0.0022', 'FontSize', fontSize);

% Report results.
message = sprintf('Ref Contrast = %.3f\nTrans Contrast = %.3f\nCircularity = %.3f\nArea in pixels = %.2f\nperimeter = %.2f\nCentroid at (x,y) = (%.1f, %.1f)\nCenter of Mass at (x,y) = (%.1f, %.1f)', ...
ref_contrast, trans_contrast, numberOfPixels2, perimeter, ...
centroid(1), centroid(2), centerOfMass(1), centerOfMass(2));
msgbox(message);


