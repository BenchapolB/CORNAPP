function [FF] = GetWH( in )
%CLEARBG Summary of this function goes here
%   Detailed explanation goes here
tic
    im = imread(in);
    BG = imread('I:\Corn\CORN APP\New Dataset\BG.JPG');
    %BG = imread('I:\Corn\CornApp2\BG.JPG');
    
    im = imresize(im,0.2);
    BG = imresize(BG,0.2);
    size(BG);
    diff = abs(im-BG);
    gray = rgb2gray(diff);
    bw = im2bw(gray,graythresh(gray));
    SE = strel('disk',5);
    for i=1:5
        bw = imdilate(bw,SE);
    end
    for i=1:5
        bw = imerode(bw,SE);
    end
    im = diff;
    stat = regionprops(bw,'BoundingBox','Area','MajorAxisLength','MinorAxisLength');
    [maxArea,index] = max([stat.Area]);
    thisBB = stat(index).BoundingBox;
    ctr = regionprops(bw,'centroid');
    theta = regionprops(bw,'orientation');
    
    %Rotate
    im = imrotate(im,-theta(index).Orientation,'bilinear');
    bw = imrotate(bw,-theta(index).Orientation,'bilinear');
    stat = regionprops(bw,'BoundingBox','Area','MajorAxisLength','MinorAxisLength');
    [maxArea,index] = max([stat.Area]);
    thisBB = stat(index).BoundingBox;
    ctr = regionprops(bw,'centroid');
    theta = regionprops(bw,'orientation');
    
    xMajor = ctr(index).Centroid(1)  +  [ -1 +1 ] * stat(index).MajorAxisLength*cosd(-1*theta(index).Orientation)/2;
    yMajor = ctr(index).Centroid(2)  +  [ -1 +1 ] * stat(index).MajorAxisLength*sind(-1*theta(index).Orientation)/2;
    xMinor = ctr(index).Centroid(1)  +  [ -1 +1 ] * stat(index).MinorAxisLength*sind(theta(index).Orientation)/2;
    yMinor = ctr(index).Centroid(2)  +  [ -1 +1 ] * stat(index).MinorAxisLength*cosd(theta(index).Orientation)/2;
%     figure;imshow(bw);

     xMajor = [stat(index).BoundingBox(1) stat(index).BoundingBox(1)+stat(index).BoundingBox(3) ];
    
    [shape,shape2] = GetShape(bw,xMajor,yMajor,xMinor,yMinor,theta(index).Orientation,stat(index).MinorAxisLength);
  
%      rectangle('Position',[stat(index).BoundingBox(1),stat(index).BoundingBox(2),stat(index).BoundingBox(3),stat(index).BoundingBox(4)],...
%    'EdgeColor','r','LineWidth',2 )    
    % disp('gethist')START : HISTOGRAM
    Color = GetLocalHist(im,thisBB);
    % END   : HISTOGRAM
    
    W = thisBB(3);
    H = thisBB(4);
    ratio = W/H; 
    WH = [W H ratio]; %3
    Color = (double(Color)*1000)/(W*H); %432
    Shape = [shape,stat(index).MajorAxisLength ]; %24
    Area = [maxArea maxArea/(W*H)];%2
    FF = [WH Color Shape Area];
    
        
    toc
end

