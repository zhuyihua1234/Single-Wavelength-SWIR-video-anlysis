% Import image
file = uigetfile('*.*');
raw_img = imread(file);
grayImage = fliplr(raw_img);
[cropped_img,rect] = imcrop(grayImage);

% Select Edge Detection Algorithm and choose threshold
edge_detection_algorithm = 'canny';
threshold = 0.1;
%%
% Create edge detection with different sigma values
BW2 = edge(cropped_img,edge_detection_algorithm,threshold,0.5);
BW3 = edge(cropped_img,edge_detection_algorithm,threshold,1);
BW4 = edge(cropped_img,edge_detection_algorithm,threshold,1.5);
BW5 = edge(cropped_img,edge_detection_algorithm,threshold,2);
BW6 = edge(cropped_img,edge_detection_algorithm,threshold,2.5);
BW7 = edge(cropped_img,edge_detection_algorithm,threshold,3);
BW8 = edge(cropped_img,edge_detection_algorithm,threshold,3.5);

subplot(2,4,1);
imshow(cropped_img);
axis on;
title('Orignial cropped Image');

subplot(2,4,2);
imshow(BW2);
axis on;
title('sigma = 0.5');

subplot(2,4,3);
imshow(BW3);
axis on;
title('sigma = 1');

subplot(2,4,4);
imshow(BW4);
axis on;
title('sigma = 1.5');

subplot(2,4,5);
imshow(BW5);
axis on;
title('sigma = 2');

subplot(2,4,6);
imshow(BW6);
axis on;
title('sigma = 2.5');

subplot(2,4,7);
imshow(BW7);
axis on;
title('sigma = 3');

subplot(2,4,8);
imshow(BW8);
axis on;
title('sigma = 3.5');