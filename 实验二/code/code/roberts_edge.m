function output = roberts_edge(input_image)
[row , col] = size(input_image);
result = zeros(row,col);
fx = [1 0 ; 0 -1];
fy = [0 1 ; -1 0];
for i = 1:(row - 1)
    for j = 1:(col - 1)
        temp = input_image([i,i+1],[j,j+1]);
        gx = fx*temp; gy = fy*temp;
        g = abs(gx) + abs(gy);
        if g >= 0.8
            result(i,j) = 255;
        end
    end
end
output = result;