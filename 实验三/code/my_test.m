%DIP19 Assignment 3
%Character Recongnition

clc;
imgInput = imread('../assert/image/5.png');
imgOutput = my_calculator(imgInput);
imwrite(imgOutput, '../assert/image/5_result.png');

imgInput = imread('../assert/image/1.png');
imgOutput = my_calculator(imgInput);
imwrite(imgOutput, '../assert/image/1_result.png');

imgInput = imread('../assert/image/2.png');
imgOutput = my_calculator(imgInput);
imwrite(imgOutput, '../assert/image/2_result.png');

imgInput = imread('../assert/image/3.png');
imgOutput = my_calculator(imgInput);
imwrite(imgOutput, '../assert/image/3_result.png');

imgInput = imread('../assert/image/4.png');
imgOutput = my_calculator(imgInput);
imwrite(imgOutput, '../assert/image/4_result.png');
%imgOutput = imgInput;

subplot(1, 2, 1);
imshow(imgInput);
subplot(1, 2, 2);
imshow(imgOutput);

imgInput2 = imread('../assert/image/test4.jpg');
imgOutput2 = my_digit(imgInput2)

imgInput3 = imread('../assert/image/test2.jpg');
imgOutput3 = my_operator(imgInput3)
% imgInput1 = imread('test2.jpg');
% imgOutput1 = my_operator(imgInput1);
