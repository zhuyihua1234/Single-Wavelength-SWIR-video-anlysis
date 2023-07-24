% Import image
file = uigetfile('*.*');
raw_img = imread(file);
grayImage = fliplr(raw_img);
%%
[cropped_img,rect] = imcrop(grayImage);


% Select Edge Detection Algorithm and choose threshold
edge_detection_algorithm = 'log';

%%
% Create edge detection with different sigma values
BW2 = edge(cropped_img,edge_detection_algorithm,0.0004);
BW3 = edge(cropped_img,edge_detection_algorithm,0.0006);
BW4 = edge(cropped_img,edge_detection_algorithm,0.0008);
BW5 = edge(cropped_img,edge_detection_algorithm,0.0010);
BW6 = edge(cropped_img,edge_detection_algorithm,0.0012);
BW7 = edge(cropped_img,edge_detection_algorithm,0.0014);
BW8 = edge(cropped_img,edge_detection_algorithm,0.0016);

subplot(2,4,1);
imshow(cropped_img);
axis on;
title('Orignial cropped Image');

subplot(2,4,2);
imshow(BW2);
axis on;
title('threshold = 0.001');

subplot(2,4,3);
imshow(BW3);
axis on;
title('threshold = 0.0012');

subplot(2,4,4);
imshow(BW4);
axis on;
title('threshold = 0.0014');

subplot(2,4,5);
imshow(BW5);
axis on;
title('threshold = 0.0016');

subplot(2,4,6);
imshow(BW6);
axis on;
title('threshold = 0.0018');

subplot(2,4,7);
imshow(BW7);
axis on;
title('threshold = 0.002');

subplot(2,4,8);
imshow(BW8);
axis on;
title('threshold = 0.0022');