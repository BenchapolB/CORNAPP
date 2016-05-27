function [Label,FMat] = GetFMat(num)
%GETFMAT Summary of this function goes here
%   Detailed explanation goes here
    type = strcat('I:\Corn\CORN APP\Unknown\',int2str(num));
    list = dir(type);
    Label = [];
    FMat = [];
    for n = 4:size(list,1)
        Label = [Label;num];
        display('processing...');
        display(strcat('Type',int2str(num)))
        path = strcat(type,'/',list(n).name);
        [FF] = GetWH(path);
        FMat = [FMat;FF];
    end
end

