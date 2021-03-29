function output = my_edgelinking(binary_image, row, col)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores
[m,n] = size(binary_image);
val = zeros(m,n);
% val1 = zeros(m,n);
%trace(binary_image,row,col,1);
% trace_lt(binary_image,row,col,1);
% trace_rb(binary_image,row,col,1);
% result_lt = out_image1;
% result_rb = out_image2;
% result = [result_rb;result_lt];
global top;
global k;
if(binary_image(row,col)>0)
top = 1;
k = 1;
edge_stack(top,1) = row;
edge_stack(top,2) = col;
top = top + 1;
while(top > 1)
    top = top - 1;
    trace(binary_image,edge_stack(top,1),edge_stack(top,2));
end
    [m,n] = size(out_image);
    for i = 1:m - 1
        if((abs(out_image(i,1) - out_image(i+1,1))) + (abs(out_image(i,2) - out_image(i+1,2))) > 15)
            for j = i + 2:m
                if((abs(out_image(i,1) - out_image(j,1))) + (abs(out_image(i,2) - out_image(j,2))) < 15)
                    out_image([i+1,j],:) = out_image([j,i+1],:);
                end
            end
        end
    end
    t = m;
    for i = 1:m - 1
        if((abs(out_image(i,1) - out_image(i+1,1))) + (abs(out_image(i,2) - out_image(i+1,2))) > 15)
            t = i + 1;
            break;
        end
    end
    %fprintf('%1.0f:%1.0f,%1.0f\n',t,abs(out_image(i,1) - out_image(i+1,1)), abs(out_image(i,2) - out_image(i+1,2)));
    i = t;
    while(t <= m)
        out_image(i,:) = [];
        t = t + 1;
    end
    result = out_image;
    output = result;
else
    output = zeros(1,2);
    %result = out_image;
end


% function trace_lt(binary_image,row,col,k)
% if(binary_image(row,col) == 255 && val(row,col)==0)
%     out_image1(k,1) = row;
%     out_image1(k,2) = col;
%     k = k + 1;
%     val(row,col) = 1;
%     for y_off = -1:1
%         for x_off = -1:1
%             %fprintf('%1.0f,%1.0f:%3.0f,%1.0f\n',row + y_off,col + x_off,binary_image(row + y_off,col + x_off),val(row + y_off,col + x_off));
%             if(~(y_off == 0 && x_off == 0) && binary_image(row + y_off,col + x_off) == 255 &&  val(row + y_off,col + x_off)==0)
%                 trace_lt(binary_image,row + y_off,col + x_off,k);
%             end
%         end
%     end
% else
% end
% end
% function trace_rb(binary_image,row,col,k)
% if(binary_image(row,col) == 255 && val1(row,col)==0)
%     out_image2(k,1) = row;
%     out_image2(k,2) = col;
%     k = k + 1;
%     val1(row,col) = 1;
%     for y_off = 1:-1:-1
%         for x_off = 1:-1:-1
%            % fprintf('%1.0f,%1.0f:%3.0f,%1.0f\n',row + y_off,col + x_off,binary_image(row + y_off,col + x_off),val1(row + y_off,col + x_off));
%             if(~(y_off == 0 && x_off == 0) && binary_image(row + y_off,col + x_off) == 255 &&  val1(row + y_off,col + x_off)==0)
%                 trace_rb(binary_image,row + y_off,col + x_off,k);
%             end
%         end
%     end
% else
% end
% end
% output = result;
% end
%八联通
function trace(binary_image,row,col)
    for y_off = 1:-1:-1
        for x_off = 1:-1:-1
            if(~(y_off == 0 && x_off == 0) && binary_image(row + y_off,col + x_off) > 0 &&  val(row + y_off,col + x_off)==0)
                out_image(k,1) = row + y_off;
                out_image(k,2) = col + x_off;
                k = k + 1;
                val(row + y_off,col + x_off) = 1;
                edge_stack(top,1) = row + y_off;
                edge_stack(top,2) = col + x_off;
                top = top + 1;
            end
        end
    end
end
%四联通
% function trace(binary_image,row,col)
%             if(binary_image(row + 1,col + 0) > 0 &&  val(row + 1,col + 0)==0)
%                 out_image(k,1) = row + 1;
%                 out_image(k,2) = col + 0;
%                 k = k + 1;
%                 val(row + 1,col) = 1;
%                 edge_stack(top,1) = row + 1;
%                 edge_stack(top,2) = col + 0;
%                 top = top + 1;
%             elseif(binary_image(row -1,col + 0) > 0 &&  val(row - 1,col + 0)==0)
%                 out_image(k,1) = row -1;
%                 out_image(k,2) = col + 0;
%                 k = k + 1;
%                 val(row - 1,col) = 1;
%                 edge_stack(top,1) = row -1;
%                 edge_stack(top,2) = col + 0;
%                 top = top + 1;
%             elseif(binary_image(row,col + 1) > 0 &&  val(row,col + 1)==0)
%                 out_image(k,1) = row;
%                 out_image(k,2) = col + 1;
%                 k = k + 1;
%                 val(row,col + 1) = 1;
%                 edge_stack(top,1) = row;
%                 edge_stack(top,2) = col + 1;
%                 top = top + 1;
%             elseif(binary_image(row,col - 1) > 0 &&  val(row,col - 1)==0)
%                 out_image(k,1) = row;
%                 out_image(k,2) = col - 1;
%                 k = k + 1;
%                 val(row,col - 1) = 1;
%                 edge_stack(top,1) = row;
%                 edge_stack(top,2) = col - 1;
%                 top = top + 1;
%             end
% end
end

