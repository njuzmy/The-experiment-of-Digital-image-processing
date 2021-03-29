function output = my_edge(input_image)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores  
%robertsËã×Ó
% [row , col] = size(input_image);
% %result = input_image;
% result = zeros(row,col);
% fx = [1 0 ; 0 -1];
% fy = [0 1 ; -1 0];
% for i = 1:(row - 1)
%     for j = 1:(col - 1)
%         temp = input_image([i,i+1],[j,j+1]);
%         gx = fx*temp; gy = fy*temp;
%         g = abs(gx) + abs(gy);
%         if g >= 0.8
%             result(i,j) = 255;
%         end
%     end
% end
% output = result;

%sobelËã×Ó
[m,n] = size(input_image);
newGrayPic=input_image;

sobelThreshold=1.1;

for j=2:m-1
    for k=2:n-1
        sobelNum=abs(input_image(j-1,k+1)+2*input_image(j,k+1)+input_image(j+1,k+1)-input_image(j-1,k-1)-2*input_image(j,k-1)-input_image(j+1,k-1))+abs(input_image(j-1,k-1)+2*input_image(j-1,k)+input_image(j-1,k+1)-input_image(j+1,k-1)-2*input_image(j+1,k)-input_image(j+1,k+1));
        if(sobelNum > sobelThreshold)
            newGrayPic(j,k)=255;
        else
            newGrayPic(j,k)=0;
        end
    end
end
output = newGrayPic;