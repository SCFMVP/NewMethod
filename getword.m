function [ word, result ] = getword( img )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    word = [];
    flag = 0;
    y1 = 8;
    y2 = 0.5;
    
    while flag == 0
        [m, n] = size(img);
        width = 0;
        while sum(img(:, width+1)) ~= 0 && width <= n-2
            width = width + 1;
        end
        temp = my_imsplit(imcrop(img, [1,1,width,m]));
        [m1, n1] = size(temp);
        if width < y1 && n1/m1>y2
            img(:, [1, width]) = 0;
            if sum(sum(img)) ~= 0
                img = my_imsplit(img);
            else
                word = [];
                flag = 1;
            end
        else
            word = my_imsplit(imcrop(img, [1, 1, width, m]));
            img(:, [1: width]) = 0;
            if sum(sum(img)) ~= 0
                img = my_imsplit(img);
                flag = 1;
            else
                img = [];
            end   
        end
    end

    result = img;
end


% function [word,result]=getword(d)
% word=[];flag=0;y1=8;y2=0.5;
%     while flag==0
%         [m,n]=size(d);
%         wide=0;
%         while sum(d(:,wide+1))~=0 && wide<=n-2
%             wide=wide+1;
%         end
%         temp=my_imsplit(imcrop(d,[1 1 wide m]));
%         [m1,n1]=size(temp);
%         if wide<y1 && n1/m1>y2
%             d(:,[1:wide])=0;
%             if sum(sum(d))~=0
%                 d=qiege(d);  % 切割出最小范围
%             else word=[];flag=1;
%             end
%         else
%             word=my_imsplit(imcrop(d,[1 1 wide m]));
%             d(:,[1:wide])=0;
%             if sum(sum(d))~=0;
%                 d=my_imsplit(d);flag=1;
%             else d=[];
%             end
%         end
%     end
% %end
%           result=d;



