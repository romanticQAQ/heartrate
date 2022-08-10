function [ X ] = f_video2signal( video_name, startFrame, endFrame)
%  �������+KLT׷��
%  ����ROI����ѡ�񲿷ֿɺ����Ż�����
video=VideoReader(video_name);
n = startFrame;
firstFrame=read(video,n);
firstFrame=firstFrame(:, :, 1);
%% KLT�ĳ�ʼ������
faceDetector = vision.CascadeObjectDetector; %����ǰ�������
%faceBbox=faceDetector(firstFrame); %�������
faceBbox = step(faceDetector, firstFrame); %�����������Ͻ����꣬�ͳ���
%���ӣ�ȡ������������������һ�����²�Ϊ���һ�У�
faceBbox = sortrows(faceBbox,3);
faceBbox = faceBbox(end,:);
%
MinEigenPoints = detectMinEigenFeatures(firstFrame, 'ROI', faceBbox);%ʹ����С����ֵ�㷨�ͷ���cornerPoints���ǵ�
firstShow=insertObjectAnnotation(firstFrame,'rectangle',faceBbox,'Face','LineWidth',2,'Color','g'); %��ʾ
firstShow=insertMarker(firstShow,MinEigenPoints.Location,'+','Color','w','Size',2);
% figure();imshow(firstShow);title('the initial');
 
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);%��ǰ�������ֵ����Ϊ2
initialize(pointTracker, MinEigenPoints.Location, firstFrame);%��ʼ��׷����
 
%% KLT׷��
oldPoints =MinEigenPoints.Location;% ��ȡ��ʼ��ʱ�����ǵ�
bboxPoints = bbox2points(faceBbox);% ��ȡ��������ĸ�����

    x1=bboxPoints(1, 1);
    x2=bboxPoints(2, 1);
    x3=bboxPoints(3, 1);
    x4=bboxPoints(4, 1);
    y1=bboxPoints(1, 2);
    y2=bboxPoints(2, 2);
    y3=bboxPoints(3, 2);
    y4=bboxPoints(4, 2);
    
    %ѡ��Ŀ������ľ�ֵ�ź�(��)
    c1=[9/20*x2+11/20*x1, 9/20*x1+11/20*x2, 9/20*x4+11/20*x3, 9/20*x3+11/20*x4 ];
    r1=[19/20*y1+1/20*y4, 19/20*y2+1/20*y3, 17/20*y2+3/20*y3, 17/20*y1+3/20*y4];
    BW1= roipoly(firstFrame,c1,r1);  % ������ֵ��Ĥͼ��
    c1=immultiply(firstFrame, BW1);
%     imshow(c1)
    signal1(1)=mean(c1(c1~=0));

    
    %ѡ��Ŀ������ľ�ֵ�ź�(��)
    c2=[0.75*x1+0.25*x2, 0.75*x2+0.25*x1, 0.75*x3+0.25*x4, 0.75*x4+0.25*x3];
    r2=[0.4*y4+0.6*y1,  0.4*y3+0.6*y2, 0.4*y2+0.6*y3, 0.4*y1+0.6*y4];
    BW2= roipoly(firstFrame,c2,r2);  % ������ֵ��Ĥͼ��
    c2=immultiply(firstFrame, BW2);
%     imshow(c2)
    signal2(1)=mean(c2(c2~=0));

    %ѡ��Ŀ������ľ�ֵ�ź�(��)
    c3=[0.5*x1+0.5*x2-5, 0.5*x1+0.5*x2+5, 0.5*x3+0.5*x4+5, 0.5*x3+0.5*x4-5];
    r3=[0.1*y1+0.9*y4-5,  0.1*y2+0.9*y3-5, 0.1*y2+0.9*y3+5, 0.1*y1+0.9*y4+5];
    BW3= roipoly(firstFrame,c3,r3);  % ������ֵ��Ĥͼ��
    c3=immultiply(firstFrame, BW3);
%     imshow(c3)
    signal3(1)=mean(c3(c3~=0));
    
%     figure();imshow(firstShow);
%     figure();imshow(c1);
%     figure();imshow(c2);
%     figure();imshow(c3);
    
n = n + 1;
% while n<(frame_num+1)%������Ƶ
while n <= endFrame
    frame = read(video,n); % ��ȡ��ǰ֡
    frame = frame(:, :, 1);
    % frame = imresize(readFrame(video),[480 640]); % ��ȡ��ǰ֡
    % frame = frames(:, :, n); % ��ȡ��ǰ֡
    %[newPoints,validity,score] = pointTracker(frame); % ��ȡ���ɵ�
    [newPoints,validity,score] = step(pointTracker, frame); % ��ȡ���ɵ�   
    
    oldPoints = oldPoints(validity, :);  % ��ȡ�����ŵ�ƥ���
    newPoints = newPoints(validity, :);  % ��ȡ�����ŵ�ƥ���(��һ�ι���)
    
    %���Ƽ��η����ϵ����һ����ȡ�������ĵ�ƥ��ԣ��ڶ��ι��ˣ�
    [xform, oldPoints, newPoints] = estimateGeometricTransform(oldPoints, newPoints, 'similarity', 'MaxDistance', 4);
    bboxPoints = transformPointsForward(xform, bboxPoints); %�ɷ����ϵ����bboxPoints
    bboxPolygon = reshape(bboxPoints', 1, []);% �ع���������
    
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
    
    %ѡ��Ŀ������ľ�ֵ�ź�(��)
    c1=[9/20*x2+11/20*x1, 9/20*x1+11/20*x2, 9/20*x4+11/20*x3, 9/20*x3+11/20*x4 ];
    r1=[19/20*y1+1/20*y4, 19/20*y2+1/20*y3, 17/20*y2+3/20*y3, 17/20*y1+3/20*y4];
    BW1= roipoly(frame,c1,r1);  % ������ֵ��Ĥͼ��
    c1=immultiply(frame, BW1);
    % imshow(c1)
    signal1(n-startFrame+1)=mean(c1(c1~=0));

    
    %ѡ��Ŀ������ľ�ֵ�ź�(��)
    c2=[0.75*x1+0.25*x2, 0.75*x2+0.25*x1, 0.75*x3+0.25*x4, 0.75*x4+0.25*x3];
    r2=[0.4*y4+0.6*y1,  0.4*y3+0.6*y2, 0.4*y2+0.6*y3, 0.4*y1+0.6*y4];
    BW2= roipoly(frame,c2,r2);  % ������ֵ��Ĥͼ��
    c2=immultiply(frame, BW2);
    % imshow(c2)
    signal2(n-startFrame+1)=mean(c2(c2~=0));

    %ѡ��Ŀ������ľ�ֵ�ź�(��)
    c3=[0.5*x1+0.5*x2-5, 0.5*x1+0.5*x2+5, 0.5*x3+0.5*x4+5, 0.5*x3+0.5*x4-5];
    r3=[0.1*y1+0.9*y4-5,  0.1*y2+0.9*y3-5, 0.1*y2+0.9*y3+5, 0.1*y1+0.9*y4+5];
    BW3= roipoly(frame,c3,r3);  % ������ֵ��Ĥͼ��
    c3=immultiply(frame, BW3);
    % imshow(c3)
    signal3(n-startFrame+1)=mean(c3(c3~=0));

%     %��ʾÿһ֡
%     trackShow = insertShape(frame,'Polygon',bboxPolygon,'LineWidth',2,'Color','g');
%     trackShow = insertMarker(trackShow,newPoints,'+','Color','w','Size',2);
%     figure(1000000);imshow(trackShow);title(strcat('NO. ',num2str(n),' Frame..'));drawnow;
    
    %�¾�����
    oldPoints = newPoints;
    setPoints(pointTracker, oldPoints);
    n=n+1;
end

X(1,:)=signal1;
X(2,:)=signal2;
X(3,:)=signal3;

end

