function output = laplacian_edge(input_image)
[row , col] = size(input_image);
result = zeros(row,col);
H = [0 -1 0 ; -1 4 -1 ; 0 -1 0];
for i = 2:(row - 1)
    for j = 2:(col - 1)
        temp = input_image([i-1,i,i+1],[j-1,j,j+1]);
        gx = H.*temp;
        g = sum(sum(gx));
        if abs(g) > 0.03
            result(i,j) = 255;
        end
    end
end
output = result;