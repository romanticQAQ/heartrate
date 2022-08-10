function [ X ] = f_video2signal( video_name, startFrame, endFrame)
%  人脸检测+KLT追踪
%  其中ROI区域选择部分可后续优化调整
video=VideoReader(video_name);
n = startFrame;
firstFrame=read(video,n);
firstFrame=firstFrame(:, :, 1);
%% KLT的初始化设置
faceDetector = vision.CascadeObjectDetector; %开启前脸侦测器
%faceBbox=faceDetector(firstFrame); %检测人脸
faceBbox = step(faceDetector, firstFrame); %人脸方框左上角坐标，和长宽
%增加：取多个人脸检测结果的最大的一个（猜测为最后一行）
faceBbox = sortrows(faceBbox,3);
faceBbox = faceBbox(end,:);
%
MinEigenPoints = detectMinEigenFeatures(firstFrame, 'ROI', faceBbox);%使用最小特征值算法和返回cornerPoints检测角点
firstShow=insertObjectAnnotation(firstFrame,'rectangle',faceBbox,'Face','LineWidth',2,'Color','g'); %显示
firstShow=insertMarker(firstShow,MinEigenPoints.Location,'+','Color','w','Size',2);
% figure();imshow(firstShow);title('the initial');
 
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);%向前后错误阈值设置为2
initialize(pointTracker, MinEigenPoints.Location, firstFrame);%初始化追踪器
 
%% KLT追踪
oldPoints =MinEigenPoints.Location;% 获取初始化时特征角点
bboxPoints = bbox2points(faceBbox);% 获取人脸框的四个坐标

    x1=bboxPoints(1, 1);
    x2=bboxPoints(2, 1);
    x3=bboxPoints(3, 1);
    x4=bboxPoints(4, 1);
    y1=bboxPoints(1, 2);
    y2=bboxPoints(2, 2);
    y3=bboxPoints(3, 2);
    y4=bboxPoints(4, 2);
    
    %选择目标区域的均值信号(上)
    c1=[9/20*x2+11/20*x1, 9/20*x1+11/20*x2, 9/20*x4+11/20*x3, 9/20*x3+11/20*x4 ];
    r1=[19/20*y1+1/20*y4, 19/20*y2+1/20*y3, 17/20*y2+3/20*y3, 17/20*y1+3/20*y4];
    BW1= roipoly(firstFrame,c1,r1);  % 创建二值掩膜图像
    c1=immultiply(firstFrame, BW1);
%     imshow(c1)
    signal1(1)=mean(c1(c1~=0));

    
    %选择目标区域的均值信号(中)
    c2=[0.75*x1+0.25*x2, 0.75*x2+0.25*x1, 0.75*x3+0.25*x4, 0.75*x4+0.25*x3];
    r2=[0.4*y4+0.6*y1,  0.4*y3+0.6*y2, 0.4*y2+0.6*y3, 0.4*y1+0.6*y4];
    BW2= roipoly(firstFrame,c2,r2);  % 创建二值掩膜图像
    c2=immultiply(firstFrame, BW2);
%     imshow(c2)
    signal2(1)=mean(c2(c2~=0));

    %选择目标区域的均值信号(下)
    c3=[0.5*x1+0.5*x2-5, 0.5*x1+0.5*x2+5, 0.5*x3+0.5*x4+5, 0.5*x3+0.5*x4-5];
    r3=[0.1*y1+0.9*y4-5,  0.1*y2+0.9*y3-5, 0.1*y2+0.9*y3+5, 0.1*y1+0.9*y4+5];
    BW3= roipoly(firstFrame,c3,r3);  % 创建二值掩膜图像
    c3=immultiply(firstFrame, BW3);
%     imshow(c3)
    signal3(1)=mean(c3(c3~=0));
    
%     figure();imshow(firstShow);
%     figure();imshow(c1);
%     figure();imshow(c2);
%     figure();imshow(c3);
    
n = n + 1;
% while n<(frame_num+1)%遍历视频
while n <= endFrame
    frame = read(video,n); % 读取当前帧
    frame = frame(:, :, 1);
    % frame = imresize(readFrame(video),[480 640]); % 读取当前帧
    % frame = frames(:, :, n); % 读取当前帧
    %[newPoints,validity,score] = pointTracker(frame); % 获取可疑点
    [newPoints,validity,score] = step(pointTracker, frame); % 获取可疑点   
    
    oldPoints = oldPoints(validity, :);  % 获取高置信点匹配对
    newPoints = newPoints(validity, :);  % 获取高置信点匹配对(第一次过滤)
    
    %估计几何仿射关系，进一步获取高质量的点匹配对（第二次过滤）
    [xform, oldPoints, newPoints] = estimateGeometricTransform(oldPoints, newPoints, 'similarity', 'MaxDistance', 4);
    bboxPoints = transformPointsForward(xform, bboxPoints); %由仿射关系更新bboxPoints
    bboxPolygon = reshape(bboxPoints', 1, []);% 重构成行向量
    
%     [x1, x2, x3, x4]=bboxPoints(:, 1);
%     [y1, y2, y3, y4]=bboxPoints(:, 2);
    x1=bboxPoints(1, 1);
    x2=bboxPoints(2, 1);
    x3=bboxPoints(3, 1);
    x4=bboxPoints(4, 1);
    y1=bboxPoints(1, 2);
    y2=bboxPoints(2, 2);
    y3=bboxPoints(3, 2);
    y4=bboxPoints(4, 2);
    
    %选择目标区域的均值信号(上)
    c1=[9/20*x2+11/20*x1, 9/20*x1+11/20*x2, 9/20*x4+11/20*x3, 9/20*x3+11/20*x4 ];
    r1=[19/20*y1+1/20*y4, 19/20*y2+1/20*y3, 17/20*y2+3/20*y3, 17/20*y1+3/20*y4];
    BW1= roipoly(frame,c1,r1);  % 创建二值掩膜图像
    c1=immultiply(frame, BW1);
    % imshow(c1)
    signal1(n-startFrame+1)=mean(c1(c1~=0));

    
    %选择目标区域的均值信号(中)
    c2=[0.75*x1+0.25*x2, 0.75*x2+0.25*x1, 0.75*x3+0.25*x4, 0.75*x4+0.25*x3];
    r2=[0.4*y4+0.6*y1,  0.4*y3+0.6*y2, 0.4*y2+0.6*y3, 0.4*y1+0.6*y4];
    BW2= roipoly(frame,c2,r2);  % 创建二值掩膜图像
    c2=immultiply(frame, BW2);
    % imshow(c2)
    signal2(n-startFrame+1)=mean(c2(c2~=0));

    %选择目标区域的均值信号(下)
    c3=[0.5*x1+0.5*x2-5, 0.5*x1+0.5*x2+5, 0.5*x3+0.5*x4+5, 0.5*x3+0.5*x4-5];
    r3=[0.1*y1+0.9*y4-5,  0.1*y2+0.9*y3-5, 0.1*y2+0.9*y3+5, 0.1*y1+0.9*y4+5];
    BW3= roipoly(frame,c3,r3);  % 创建二值掩膜图像
    c3=immultiply(frame, BW3);
    % imshow(c3)
    signal3(n-startFrame+1)=mean(c3(c3~=0));

%     %显示每一帧
%     trackShow = insertShape(frame,'Polygon',bboxPolygon,'LineWidth',2,'Color','g');
%     trackShow = insertMarker(trackShow,newPoints,'+','Color','w','Size',2);
%     figure(1000000);imshow(trackShow);title(strcat('NO. ',num2str(n),' Frame..'));drawnow;
    
    %新旧轮替
    oldPoints = newPoints;
    setPoints(pointTracker, oldPoints);
    n=n+1;
end

X(1,:)=signal1;
X(2,:)=signal2;
X(3,:)=signal3;

end

