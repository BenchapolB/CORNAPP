function [ output ] = GetLocalHist( im,thisBB )
%GETLOCALHIST Summary of this function goes here
%   Detailed explanation goes here
    Color = [];
    stat = [];
    hsv = (rgb2hsv(im));      
    hsv = hsv(floor(thisBB(2)+1):floor(thisBB(2)+thisBB(4)),floor(thisBB(1)+1):floor(thisBB(1)+thisBB(3)),:);
    [x, y,z]=size(hsv);
    im1 = hsv(1:floor(x/2),1:floor(y/2),:);
    im2 = hsv(1:floor(x/2),floor(y/2):y,:);
    im3 = hsv(floor(x/2):x,1:floor(y/2),:);
    im4 = hsv(floor(x/2):x,floor(y/2):y,:);
    
    img = im1;
    hist_h = imhist(img(:,:,1),50)';
    hist_s = imhist(img(:,:,2),50)';
    h = img(:,:,1);
    s = img(:,:,2);
    sd = [std(h(:)) std(s(:))];
    mu = [mean(h(:)) mean(s(:))];
    skew = [skewness(h(:)) skewness(s(:))];
    kur = [kurtosis(h(:)) kurtosis(s(:))]; 
    Color = [Color, hist_h, hist_s];
    stat = [stat, sd, mu, skew, kur ];
    
    img = im2;
    hist_h = imhist(img(:,:,1),50)';
    hist_s = imhist(img(:,:,2),50)';
    h = img(:,:,1);
    s = img(:,:,2);
    sd = [std(h(:)) std(s(:))];
    mu = [mean(h(:)) mean(s(:))];
    skew = [skewness(h(:)) skewness(s(:))];
    kur = [kurtosis(h(:)) kurtosis(s(:))]; 
    Color = [Color, hist_h, hist_s];
    stat = [stat, sd, mu, skew, kur ];
    
    img = im3;
    hist_h = imhist(img(:,:,1),50)';
    hist_s = imhist(img(:,:,2),50)';
    h = img(:,:,1);
    s = img(:,:,2);
    sd = [std(h(:)) std(s(:))];
    mu = [mean(h(:)) mean(s(:))];
    skew = [skewness(h(:)) skewness(s(:))];
    kur = [kurtosis(h(:)) kurtosis(s(:))]; 
    Color = [Color, hist_h, hist_s];
    stat = [stat, sd, mu, skew, kur ];
    
    img = im4;
    hist_h = imhist(img(:,:,1),50)';
    hist_s = imhist(img(:,:,2),50)';
    h = img(:,:,1);
    s = img(:,:,2);
    sd = [std(h(:)) std(s(:))];
    mu = [mean(h(:)) mean(s(:))];
    skew = [skewness(h(:)) skewness(s(:))];
    kur = [kurtosis(h(:)) kurtosis(s(:))]; 
    Color = [Color, hist_h, hist_s];
    stat = [stat, sd, mu, skew, kur ];
    output = [Color stat];
end

