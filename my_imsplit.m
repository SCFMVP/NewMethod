function [ split_img ] = my_imsplit( img )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

% 获取图像的大小
[m, n] = size(img);
top = 1;
bottom = m;
left = 1;
right = n;

% 获取字符的顶部位置
while sum(img(top, :)) == 0 && top <= m
    top = top + 1;
end

% 获取字符的底部位置
while sum(img(bottom, :)) == 0 && bottom >= 1
    bottom = bottom -1;
end

% 获取字符的左边界
while sum(img(:, left)) == 0 && left <= n
    left = left + 1;
end

% 获取字符的右边界
while sum(img(:, right)) == 0 && right >= 1
    right = right - 1;
end

% 得到宽和高
width = right - left;
height = bottom - top;

% 切割图像
split_img = imcrop(img, [left top width height]);

end

