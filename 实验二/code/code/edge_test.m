%DIP16 Assignment 2
%Edge Detection
%In this assignment, you should build your own edge detection and edge linking 
%function to detect the edges of a image.
%Please Note you cannot use the build-in matlab edge and bwtraceboundary function
%We supply four test images, and you can use others to show your results for edge
%detection, but you just need do edge linking for rubberband_cap.png.
clc; clear all;
% Load the test image
imgTest = im2double(imread('rubberband_cap.png'));
imgTestGray = rgb2gray(imgTest);
figure; clf;
imshow(imgTestGray);
%now call your function my_edge, you can use matlab edge function to see
%the last result as a reference first
sigma = 1.9;
gausFilter = fspecial('gaussian',[5,5],sigma);
%use gaussian filter to process the image first
filter_gray_image = imfilter(imgTestGray,gausFilter,'replicate');
img_edge =my_edge(filter_gray_image);
figure;clf;
imshow(img_edge);
title('sobel');
% 
% img_edge1 =prewitt_edge(filter_gray_image);
% figure;clf;
% imshow(img_edge1);
% title('prewitt');
% 
% img_edge2 =roberts_edge(filter_gray_image);
% figure;clf;
% imshow(img_edge2);
% title('roberts');
% 
% img_edge3 =laplacian_edge(filter_gray_image);
% figure;clf;
% imshow(img_edge3);
% title('laplacian');
% 
% img_edge4 =canny_edge(filter_gray_image);
% figure;clf;
% imshow(img_edge4);
% title('canny');
%img_edge = my_edge(filter_gray_image);
figure('name','plot');
background = im2bw(imgTest, 1);
imshow(background);
imtool(img_edge);
% %using imtool, you select a object boundary to trace, and choose
% %an appropriate edge point as the start point 
% %now call your function my_edgelinking, you can use matlab bwtraceboundary 
% %function to see the last result as a reference first. please trace as many 
% %different object boundaries as you can, and choose different start edge points.
% %Bxpc = bwtraceboundary(img_edge, [105, 268], 'N');
Bxpc = my_edgelinking(img_edge,20, 284);
hold on
plot(Bxpc(:,2), Bxpc(:,1), 'w', 'LineWidth', 1);
title('plot');