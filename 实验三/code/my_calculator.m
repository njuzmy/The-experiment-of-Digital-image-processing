function output = my_calculator(input_image)
%in this function, you should finish the character recognition task.
%the input parameter is a matrix of an image which contains several expressions
%the output parameter is a matrix of an image which contains the results of expressions
startr = 6;
startc = 6;
endr = 99;
endc = 337;                           %由于在整个大图里识别，识别精度不是很高，效果不理想，所以可以将整个大图划分为一个个小块，这里是确定第一块的起始与截至坐标
for i = 1 : 10
    for j = 1 : 3
        out = input_image(startr + 10:endr - 10,startc + 10:endc - 10);
        ocrResults = ocr(out, 'CharacterSet','0 1 2 3 4 5 6 7 8 9 - + =');      %利用matlab自带的库函数进行识别字符，且要求识别字符的范围在数字以及符号之间
        text1 = ocrResults.Text;                  %获得识别后的字符串
        if (strlength(text1) ~= 0)
            %text1(1)
            if(text1(2) == '-')                   %这里是对字符串进行分解计算
                result = (text1(1) - '0') -( text1(3) - '0');
            else
                result = (text1(1) - '0') + (text1(3) - '0');
            end
            if (result >= 0 && result <= 9)
            str = num2str(result);
            input_image = insertText(input_image, [startc + 260 startr], str,'FontSize',50,'BoxColor','white','BoxOpacity',0);     %将计算得到的结果添加到图片中去，这里使用了insertText函数，里面参数的定义分别为字体大小，背景颜色，背景颜色透明度
            end
        else
              input_image1 = insertText(input_image, [startc + 100 startr + 20], ' ','FontSize',30,'BoxColor','black','BoxOpacity',1);   %这里有一个特例，实验中发现对于“- 1”无法正确识别，需要特殊处理
              out = input_image1(startr + 10:endr - 10,startc + 10:endc - 10);
%             H = im2double(out);
%             [M , N] = size(H);
              ocrResults = ocr(out, 'CharacterSet','0 1 2 3 4 5 6 7 8 9 - +');
              text = ocrResults.Text;
              result = (text(1) - '0') - (text(3) - '0');
              str = num2str(result);
              input_image = insertText(input_image, [startc + 260 startr], str,'FontSize',50,'BoxColor','white','BoxOpacity',0);
%               startk = 0; endk = 0;
%               for t = 1 : N
%                  for k = 1 : M - 1
%                     if(H(k,t) == 1 && H(k, t+1) ~= 1)
%                         startk = t;
%                         break;
%                     end
%                  end
%               end
%               for t = startk + 1: N
%                   for k = 1 : M
%                     if(input_image(k,t) ~= 1 && input_image(k, t+1) == 1)
%                         endk = t;
%                     end
%                  end
%               end  
%               startk
%               endk
%               out = input_image(startr + 10 : endr - 10 , startk : endk);
%               figure;
%               imshow(out);
        end
        startc = startc +  331;       %获得下一个块的起始（左上角），结尾（右下角）坐标
        endc = endc +  331;
    end
    startc = 11;
    endc = 335;
    startr = startr + 93;
    endr = endr + 93;
end
output = input_image;



