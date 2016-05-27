    function [ im1,im2 ] = GetPic( image )
%function [] = GetPic( im )

%GETPIC Summary of this function goes here
%   Detailed explanation goes here
    im = imread(image);
    im = imresize(im,0.2);
    BG = imread('I:\Corn\CORN APP\New Dataset\BG.JPG');
    
    %BG = imread('BG.JPG');
    BG = imresize(BG,0.2);
    diff = im-BG;
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
    disp(thisBB);
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
    im2 = uint8(bw)*256;
    im1 = insertShape(uint8(bw)*256,'rectangle',thisBB,'LineWidth',5,'Color','red');
    im3 = im1;
    im3 = insertShape(im3,'rectangle',[thisBB(1),thisBB(2),thisBB(3)/2,thisBB(4)],'LineWidth',5,'Color','red');
    im3 = insertShape(im3,'rectangle',[thisBB(1),thisBB(2),thisBB(3),thisBB(4)/2],'LineWidth',5,'Color','red');
    imshow(im3);
    
    for i=1:size(shape2)
        im2 = insertShape(im2,'rectangle',[shape2(i,1)-5,shape2(i,2)-5,10,10],'LineWidth',10,'Color','green');
        %im1 = insertShape(im1,'rectangle',[shape2(i,1)-5,shape2(i,2)-5,10,10],'LineWidth',10,'Color','green');
    end
    
    hsv = rgb2hsv(im);
    %im2 = imhist(hsv(:,:,1));
    imwrite(im1,'im1.jpg','jpeg');
    imwrite(im2,'im2.jpg','jpeg');
    imwrite(im3,'im3.jpg','jpeg');
    
    W = thisBB(3);
    H = thisBB(4);
    Ma = stat(index).MajorAxisLength;
    Mi = stat(index).MinorAxisLength;
    Shape = shape(:,4)';

end

