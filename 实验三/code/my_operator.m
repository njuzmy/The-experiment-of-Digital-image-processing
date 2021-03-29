function output = my_operator(input_image)
%in this function, you should finish the operator recognition task.
%the input parameter is a matrix of an image which contains an operator.
%the output parameter represents which operator it is. 
%H = im2double(input_image);
%第一种方法 使用knn分类算法识别字符
[M,N,Z] = size(input_image);    %单独做符号识别也无效，需要做特殊处理
binary = im2bw(input_image);
out = binary(M/2 - 20:M/2 + 20, N/2 - 20:N/2 + 20, :);    %使用本函数必须要保证需要识别的字符在图片中心
plus = imread('../assert/train/plus.JPG');
minus = imread('../assert/train/minus.JPG');
equal = imread('../assert/train/equal.JPG');
plus = im2bw(plus);
minus = im2bw(minus);
equal = im2bw(equal);
plus = imresize(plus,[41,41]);
minus = imresize(minus,[41,41]);
equal = imresize(equal,[41,41]);      %读取训练图片，将他们用同一种规格（41 * 41的矩阵）表示
p = plus(:)';
m = minus(:)';
e = equal(:)';
X = [p;m;e];                          %训练矩阵，每一行对应一个样本数据
X = double(X);
Y = ['+';'-';'='];                    %标签，用于表示每个样本的标签，这里直接使用对应的字符作为标签
mdl = fitcknn(X,Y,'NumNeighbors',1);  %调用matlab内部的knn训练函数
out = out(:)';
out = double(out);
outclass = predict(mdl,out);          %使用knn分类器模型识别样本字符图片
output = outclass
%out = rgb2gray(out);
% input_image(1:M, N/2:N/2 + 20,:) = out;
% input_image(1:M, N/2+20:N/2+40,:) = out;
% input_image(1:M, N/2+40:N/2+60,:) = out;
%input_image = input_image(M/2 - 30: M/2 +30, N/2 - 100:N/2 + 100, :);
% input_image(1:M, N - 60:N) = out;
% 
% level = graythresh(input_image);
% BW = imbinarize(input_image,level);
% % ocrResults1 = ocr(out, 'CharacterSet','+ - =');
% % text1 = ocrResults1.Text
% figure;
% imshow(input_image);
% input_image = insertText(input_image, [N * 3/4 M/2 - 25], ' ','FontSize',30,'BoxColor','black','BoxOpacity',1);
%input_image = insertText(input_image, [N * 6/8 M/2 - 55], '6','FontSize',60,'BoxColor','white','BoxOpacity',0);
% figure;
% imshow(input_image);

% 第二种方法  使用matlab自带ocr函数
% input_image = insertText(input_image, [N/8 M/2 - 25], ' ','FontSize',30,'BoxColor','black','BoxOpacity',1);
% input_image = insertText(input_image, [N/4 M/2 - 25], ' ','FontSize',30,'BoxColor','black','BoxOpacity',1);
% ocrResults = ocr(input_image);
% text = ocrResults.Text
% if(strlength(text)~=0)                  %- = 两个符号怎么都无法识别，所以只能自己寻找特征手动分类
% for i = 1 : strlength(text)
%     if(text(i) == '-' || text(i) == '+' || text(i) == '=')
%         output = text(i)
%         break;
%     end
% end
% else
%     t = 1;
%     for k = 1 : M - 1
%         if((input_image(k,N/2) >50 && input_image(k + 1,N/2) < 10))
%             t = t +1;
%         end
%     end
%     if (t == 2)
%         output = '-'
%     else
%         output = '='
%     end
% end  