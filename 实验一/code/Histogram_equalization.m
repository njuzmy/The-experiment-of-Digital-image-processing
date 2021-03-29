function [output] = Histogram_equalization(input_image)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    
    %method 1:
    r=input_image(:,:,1);
    v=input_image(:,:,2);
    b=input_image(:,:,3);
    r1 = hist_equal(r);
    v1 = hist_equal(v);
    b1 = hist_equal(b);
    output = cat(3,r1,v1,b1);
    %figure, imshow(cat(3,r1,v1,b1)),,title('RGB图像均衡化'); 
    
    
    %method 2:
    HSI_image = rgb2hsi(input_image);
    h = HSI_image(:,:,1);
    s = HSI_image(:,:,2);
    i = HSI_image(:,:,3);
    h1 = hist_equal(h);
    s1 = hist_equal(s);
    i1 = hist_equal(i);
    %figure, imshow(hsi2rgb(cat(3,h,s1,i1))),title('HSI图像均衡化');
    %output = hsi2rgb(cat(3,h,s,i1));
    
    %methord 3
    HSV_image = rgb2hsv(input_image);
    h = HSV_image(:,:,1);
    s = HSV_image(:,:,2);
    v = HSV_image(:,:,3);
    h1 = hist_equal(h);
    s1 = hist_equal(s);
    v1 = hist_equal(v);
    %figure, imshow(hsi2rgb(cat(3,h,s1,i1)));
    %output = hsv2rgb(cat(3,h,s,v1));
else
    %this is a gray image
    [output] = hist_equal(input_image);
    
end

    function [output2] = hist_equal(input_channel)
    %you should complete this sub-function
    %output2 = histeq(input_channel);
    H = im2double(input_channel);
    [M,N] = size(H);
    [counts,x] = imhist(H);
    location = find(counts ~=0);
    MinCDF = min(counts(location));
    for j = 1:length(location)
        CDF = sum(counts(location(1:j)));
        P = H==x(location(j));
        H(P) = (CDF -MinCDF)/(M*N-MinCDF);
    end
    output2 = H;
    end
    
    function hsi = rgb2hsi(rgb)
    rgb = im2double(rgb);  
    r = rgb(:, :, 1);  
    g = rgb(:, :, 2);  
    b = rgb(:, :, 3);  
    num = 0.5*((r - g) + (r - b));  
    den = sqrt((r - g).^2 + (r - b).*(g - b));  
    theta = acos(num./(den + eps));
    H = theta;  
    H(b > g) = 2*pi - H(b > g);  
    H = H/(2*pi);  
    num = min(min(r, g), b);  
    den = r + g + b;  
    den(den == 0) = eps; 
    S = 1 - 3.* num./den;  
    H(S == 0) = 0;  
    I = (r + g + b)/3; 
    hsi = cat(3, H, S, I);  
    end

    function rgb = hsi2rgb(hsi)
    H = hsi(:, :, 1) * 2 * pi; 
    S = hsi(:, :, 2); 
    I = hsi(:, :, 3); 
    R = zeros(size(hsi, 1), size(hsi, 2)); 
    G = zeros(size(hsi, 1), size(hsi, 2)); 
    B = zeros(size(hsi, 1), size(hsi, 2)); 
    idx = find( (0 <= H) & (H < 2*pi/3)); 
    B(idx) = I(idx) .* (1 - S(idx)); 
    R(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx)) ./ cos(pi/3 - H(idx))); 
    G(idx) = 3*I(idx) - (R(idx) + B(idx)); 
    idx = find( (2*pi/3 <= H) & (H < 4*pi/3) ); 
    R(idx) = I(idx) .* (1 - S(idx)); 
    G(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 2*pi/3) ./ cos(pi - H(idx))); 
    B(idx) = 3*I(idx) - (R(idx) + G(idx)); 
    idx = find( (4*pi/3 <= H) & (H <= 2*pi)); 
    G(idx) = I(idx) .* (1 - S(idx)); 
    B(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 4*pi/3) ./cos(5*pi/3 - H(idx))); 
    R(idx) = 3*I(idx) - (G(idx) + B(idx)); 
    rgb = cat(3, R, G, B); 
    rgb = max(min(rgb, 1), 0); 
    end
end