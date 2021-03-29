function output = prewitt_edge(input_image)
[row , col] = size(input_image);
result = zeros(row,col);
fx = [-1 0 1 ; -1 0 1 ; -1 0 1];
fy = [-1 -1 -1 ; 0 0 0 ; 1 1 1];
for i = 2:(row - 1)
    for j = 2:(col - 1)
        temp = input_image([i-1,i,i+1],[j-1,j,j+1]);
        gx = fx.*temp; gy = fy.*temp;
        g = abs(sum(sum(gx))) + abs(sum(sum(gy)));
        if g >= 0.8
            result(i,j) = 255;
        end
    end
end
output = result;