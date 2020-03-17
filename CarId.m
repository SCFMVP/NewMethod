% ******************************************************
% auther: later
% time  : 2018/10/26 17:12
% tip   : 车牌识别
% change: 
% *******************************************************
function varargout = CarId(varargin)
% CARID MATLAB code for CarId.fig
%      CARID, by itself, creates a new CARID or raises the existing
%      singleton*.
%
%      H = CARID returns the handle to a new CARID or the handle to
%      the existing singleton*.
%
%      CARID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CARID.M with the given input arguments.
%
%      CARID('Property','Value',...) creates a new CARID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CarId_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CarId_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CarId

% Last Modified by GUIDE v2.5 26-Oct-2018 20:30:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CarId_OpeningFcn, ...
                   'gui_OutputFcn',  @CarId_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CarId is made visible.
function CarId_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CarId (see VARARGIN)

% Choose default command line output for CarId
handles.output = hObject;


%隐藏坐标轴
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
set(handles.axes4,'visible','off');
set(handles.axes5,'visible','off');
set(handles.axes6,'visible','off');
set(handles.axes7,'visible','off');
set(handles.axes8,'visible','off');
set(handles.axes9,'visible','off');
set(handles.axes10,'visible','off');
set(handles.axes11,'visible','off');
set(handles.axes12,'visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CarId wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CarId_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Get default command line output from handles structure
varargout{1} = handles.output;

%======================my code========================%
% tip : 被删除的callback自己手动添加一下...55555.....
function openLocal_Callback(hObject,eventdata,handles)
[filename, pathname]=uigetfile({'*.jpg; *.png; *.bmp; *.tif';'*.png';'All Image Files';'*.*'},'请选择图片路径');
if pathname==0
    return;
end
I=imread([pathname filename]);
%显示原图
    axes(handles.axes1)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('原图');
    handles.I=I;        %更新图像
% Update handles structure
guidata(hObject, handles);

function openCamera_Callback(hObject,eventdata,handles)
    imaqhwinfo
    vid = videoinput('winvideo',1);
    usbVidRes1=get(vid,'videoResolution');%获取视频的尺寸
    nBands1=get(vid,'NumberOfBands');%采集视频的颜色通道
    axes(handles.axes1);
    hImage1=imshow(zeros(usbVidRes1(2),usbVidRes1(1),nBands1));
    preview(vid,hImage1);
    handles.vid=vid;
% Update handles structure
guidata(hObject, handles);

function btnTakePhoto_Callback(hObject,eventdata,handles)
    vid=handles.vid;
    frame = getsnapshot(vid);
    axes(handles.axes1);
    imwrite(frame,'I.png');
    I=imread('I.png');
    axes(handles.axes1)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('拍摄完成');
    handles.I=I;     %更新原图
% Update handles structure
guidata(hObject, handles);

%下面在使用原图方法: handles.I


% --- Executes on button press in btnGray2.
function btnGray2_Callback(hObject, eventdata, handles)
% hObject    handle to btnGray2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.Cut;
    I = rgb2gray(I);
    axes(handles.axes8)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('灰度处理');
    handles.gray2=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnBalance.
function btnBalance_Callback(hObject, eventdata, handles)
% hObject    handle to btnBalance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.gray2;
    I = histeq(I);
    axes(handles.axes9)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('直方图均衡化');
    handles.balance=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnDouble.
function btnDouble_Callback(hObject, eventdata, handles)
% hObject    handle to btnDouble (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.balance;
    I = im2bw(I, 0.76);
    axes(handles.axes10)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('图像二值化');
    handles.double=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnMid.
function btnMid_Callback(hObject, eventdata, handles)
% hObject    handle to btnMid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.double;
    I = medfilt2(I);
    axes(handles.axes11)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('中值滤波');
    handles.Mid=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnCut2.
function btnCut2_Callback(hObject, eventdata, handles)
% hObject    handle to btnCut2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=handles.Mid;
I = my_imsplit(I);  %切割图像
[m, n] = size(I);

s = sum(I);    %sum(x)就是竖向相加，求每列的和，结果是行向量;
j = 1;
k1 = 1;
k2 = 1;
while j ~= n
    while s(j) == 0
        j = j + 1;
    end
    k1 = j;
    while s(j) ~= 0 && j <= n-1
        j = j + 1;
    end
    k2 = j + 1;
    if k2 - k1 > round(n / 6.5)
        [val, num] = min(sum(I(:, [k1+5:k2-5])));
        I(:, k1+num+5) = 0;
    end
end

y1 = 10;
y2 = 0.25;
flag = 0;
word1 = [];
while flag == 0
    [m, n] = size(I);
    left = 1;
    width = 0;
    while sum(I(:, width+1)) ~= 0
        width = width + 1;
    end
    if width < y1
        I(:, [1:width]) = 0;
        I = my_imsplit(I);
    else
        temp = my_imsplit(imcrop(I, [1,1,width,m]));
        [m, n] = size(temp);
        all = sum(sum(temp));
        two_thirds=sum(sum(temp([round(m/3):2*round(m/3)],:)));
        if two_thirds/all > y2
            flag = 1;
            word1 = temp;
        end
        I(:, [1:width]) = 0;
        I = my_imsplit(I);
    end
end

 % 分割出第二个字符
 [word2,I]=getword(I);
 % 分割出第三个字符
 [word3,I]=getword(I);
 % 分割出第四个字符
 [word4,I]=getword(I);
 % 分割出第五个字符
 [word5,I]=getword(I);
 % 分割出第六个字符
 [word6,I]=getword(I);
 % 分割出第七个字符
 [word7,I]=getword(I);

 figure;

 word1=imresize(word1,[40 20]);%imresize对图像做缩放处理，常用调用格式为：B=imresize(A,ntimes,method)；其中method可选nearest,bilinear（双线性）,bicubic,box,lanczors2,lanczors3等
 word2=imresize(word2,[40 20]);
 word3=imresize(word3,[40 20]);
 word4=imresize(word4,[40 20]);
 word5=imresize(word5,[40 20]);
 word6=imresize(word6,[40 20]);
 word7=imresize(word7,[40 20]);

 subplot(5,7,15),imshow(word1),title('1');
 subplot(5,7,16),imshow(word2),title('2');
 subplot(5,7,17),imshow(word3),title('3');
 subplot(5,7,18),imshow(word4),title('4');
 subplot(5,7,19),imshow(word5),title('5');
 subplot(5,7,20),imshow(word6),title('6');
 subplot(5,7,21),imshow(word7),title('7');
 
 imwrite(word1,'1.jpg'); % 创建七位车牌字符图像
 imwrite(word2,'2.jpg');
 imwrite(word3,'3.jpg');
 imwrite(word4,'4.jpg');
 imwrite(word5,'5.jpg');
 imwrite(word6,'6.jpg');
 imwrite(word7,'7.jpg');


% --- Executes on button press in btnSelect.
function btnSelect_Callback(hObject, eventdata, handles)
% hObject    handle to btnSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 liccode=char(['0':'9' 'A':'Z' '京辽鲁陕苏豫浙贵']);%建立自动识别字符代码表；'京津沪渝港澳吉辽鲁豫冀鄂湘晋青皖苏赣浙闽粤琼台陕甘云川贵黑藏蒙桂新宁'
 % 编号：0-9分别为 1-10;A-Z分别为 11-36;
 % 京  津  沪  渝  港  澳  吉  辽  鲁  豫  冀  鄂  湘  晋  青  皖  苏
 % 赣  浙  闽  粤  琼  台  陕  甘  云  川  贵  黑  藏  蒙  桂  新  宁
 % 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 
 % 60 61 62 63 64 65 66 67 68 69 70
 subBw2 = zeros(40, 20);
 num = 1;   % 车牌位数
 for i = 1:7
    ii = int2str(i);    % 将整型数据转换为字符串型数据
    word = imread([ii,'.jpg']); % 读取之前分割出的字符的图片
    segBw2 = imresize(word, [40,20], 'nearest');    % 调整图片的大小
    segBw2 = im2bw(segBw2, 0.5);    % 图像二值化
    if i == 1   % 字符第一位为汉字，定位汉字所在字段
        kMin = 37;
        kMax = 44;
    elseif i == 2   % 第二位为英文字母，定位字母所在字段
        kMin = 11;
        kMax = 36;
    elseif i >= 3   % 第三位开始就是数字了，定位数字所在字段
        kMin = 1;
        kMax = 36;
    end
    
    l = 1;
    for k = kMin : kMax
        fname = strcat('model\',liccode(k),'.jpg');  % 根据字符库找到图片模板
        samBw2 = imread(fname); % 读取模板库中的图片
        samBw2 = im2bw(samBw2, 0.5);    % 图像二值化
        
        % 将待识别图片与模板图片做差
        for i1 = 1:40
            for j1 = 1:20
                subBw2(i1, j1) = segBw2(i1, j1) - samBw2(i1 ,j1);
            end
        end
        
        % 统计两幅图片不同点的个数，并保存下来
        Dmax = 0;
        for i2 = 1:40
            for j2 = 1:20
                if subBw2(i2, j2) ~= 0
                    Dmax = Dmax + 1;
                end
            end
        end
        error(l) = Dmax;
        l = l + 1;
    end
    
    % 找到图片差别最少的图像
    errorMin = min(error);
    findc = find(error == errorMin);
%     error
%     findc
       
    % 根据字库，对应到识别的字符
    Code(num*2 - 1) = liccode(findc(1) + kMin - 1);
    Code(num*2) = ' ';
    num = num + 1;
 end
 set(handles.text4,'string',Code);
 axes(handles.axes12)     %将Tag值为axes1的坐标轴置为当前
  imshow(handles.Cut,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
  title('车牌');

      % 显示识别结果
 disp(Code);
 msgbox(Code,'识别出的车牌号');


% --- Executes on button press in btnFushi.
function btnFushi_Callback(hObject, eventdata, handles)
% hObject    handle to btnFushi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.edge;
    se=[1;1;1];
    I = imerode(I, se);
    axes(handles.axes4)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('图像腐蚀');
    handles.Fushi=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnSoft.
function btnSoft_Callback(hObject, eventdata, handles)
% hObject    handle to btnSoft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.Fushi;
    se = strel('rectangle', [30, 30]);
    I = imclose(I, se);
    axes(handles.axes5)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('平滑处理');
    handles.Soft=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnRemove.
function btnRemove_Callback(hObject, eventdata, handles)
% hObject    handle to btnRemove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.Soft;
    I = bwareaopen(I, 2200);
    axes(handles.axes6)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('移除对象');
    handles.Remove=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnCut.
function btnCut_Callback(hObject, eventdata, handles)
% hObject    handle to btnCut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img7=handles.Remove;
[y, x, z] = size(img7);
img8 = double(img7);    % 转成双精度浮点型

% 车牌的蓝色区域
% Y方向
blue_Y = zeros(y, 1);
for i = 1:y
    for j = 1:x
        if(img8(i, j) == 1) % 判断车牌位置区域
            blue_Y(i, 1) = blue_Y(i, 1) + 1;    % 像素点统计
        end
    end
end

% 找到Y坐标的最小值
img_Y1 = 1;
while (blue_Y(img_Y1) < 5) && (img_Y1 < y)
    img_Y1 = img_Y1 + 1;
end

% 找到Y坐标的最大值
img_Y2 = y;
while (blue_Y(img_Y2) < 5) && (img_Y2 > img_Y1)
    img_Y2 = img_Y2 - 1;
end

% x方向
blue_X = zeros(1, x);
for j = 1:x
    for i = 1:y
        if(img8(i, j) == 1) % 判断车牌位置区域
            blue_X(1, j) = blue_X(1, j) + 1;
        end
    end
end

% 找到x坐标的最小值
img_X1 = 1;
while (blue_X(1, img_X1) < 5) && (img_X1 < x)
    img_X1 = img_X1 + 1;
end

% 找到x坐标的最小值
img_X2 = x;
while (blue_X(1, img_X2) < 5) && (img_X2 > img_X1)
    img_X2 = img_X2 - 1;
end

% 对图像进行裁剪
img9 = handles.I(img_Y1:img_Y2, img_X1:img_X2, :);
axes(handles.axes7)     %将Tag值为axes1的坐标轴置为当前
imshow(img9,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
title('图像裁剪');
% 保存提取出来的车牌图像
imwrite(img9, '车牌图像.jpg');
handles.Cut=img9;     %更新原图
% Update handles structure
guidata(hObject, handles);





% --- Executes on button press in btnGray1.
function btnGray1_Callback(hObject, eventdata, handles)
% hObject    handle to btnGray1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.I;
    I = rgb2gray(I);
    axes(handles.axes2)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('灰度处理');
    handles.gray1=I;     %更新原图
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in btnEdge.
function btnEdge_Callback(hObject, eventdata, handles)
% hObject    handle to btnEdge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    I=handles.gray1;
    I = edge(I, 'roberts', 0.15, 'both');
    axes(handles.axes3)     %将Tag值为axes1的坐标轴置为当前
    imshow(I,[]);   %解决图像太大无法显示的问题.why?貌似会自动缩放
    title('roberts边缘检测');
    handles.edge=I;     %更新原图
% Update handles structure
guidata(hObject, handles);

%========================follow is Menu==============================


% --------------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf)

% --------------------------------------------------------------------
function ReStart_Callback(hObject, eventdata, handles)
% hObject    handle to ReStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web https://blog.csdn.net/qq_37832932

% --------------------------------------------------------------------
function Auther_Callback(hObject, eventdata, handles)
% hObject    handle to Auther (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('latermvp@gmail.com','邮箱');

% --------------------------------------------------------------------
function Block_Callback(hObject, eventdata, handles)
% hObject    handle to Block (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web https://blog.csdn.net/qq_37832932
