function output = canny_edge(input_image)
[row , col] = size(input_image);
result = zeros(row,col);
dx = [-1 0 1 ; -2 0 2 ; -1 0 1];
dy = [-1 -2 -1 ; 0 0 0 ; 1 2 1];
value = zeros(row,col);
direction = zeros(row,col);
for i = 2:(row - 1)
    for j = 2:(col - 1)
        temp = input_image([i-1,i,i+1],[j-1,j,j+1]);        
        gx = dx.*temp; gy = dy.*temp;
        value(i,j) = abs(sum(sum(gx))) + abs(sum(sum(gy)));
        direction(i,j) = atan2(sum(sum(gy)),sum(sum(gx)));
    end
end
for i = 2:(row-1)
    for j = 2:(col-1)
        if (direction(i,j) > 7*pi/8) || (direction(i,j) < -7*pi/8)...
            || ((direction(i,j) < pi/8) && (direction(i,j) > -pi/8)) %????
            if (value(i,j)>value(i,j-1)) && (value(i,j)>value(i,j+1))
                result(i,j) = value(i,j);
            end
        elseif ((direction(i,j) > pi/8)&&(direction(i,j) < 3*pi/8)) || ...
                ((direction(i,j) > -7*pi/8)&&(direction(i,j) < -5*pi/8))
            if (value(i,j)>value(i-1,j+1)) && (value(i,j)>value(i+1,j-1))
                result(i,j) = value(i,j);
            end
        elseif ((direction(i,j) > 3*pi/8)&&(direction(i,j) < 5*pi/8)) || ...
                ((direction(i,j) > -5*pi/8)&&(direction(i,j) < -3*pi/8)) %???¡À
            if (value(i,j) > value(i-1,j)) && (value(i,j) > value(i+1,j))
                result(i,j) = value(i,j);
            end
        else
            if (value(i,j) > value(i-1,j-1)) && (value(i,j) > value(i+1,j+1))
                result(i,j) = value(i,j);
            end
        end
    end
end
output = result;