clc
close all
clear all
load('type1.mat')
load('type2.mat')
load('type3.mat')
load('type4.mat')
load('type5.mat')
load('type6.mat')
load('type7.mat')
load('type8.mat')
load('type9.mat')
load('type10.mat')
close all
x = type1;

a = 1;
[train_label,train_set] = GetFMatF(a,[],[],0,1,x);
Loop = ceil(size(train_label,1));
    for i = 1:Loop
        rand = randperm(10,1);
        
        if ( rand ~= a )
            switch rand
                case 1
                    [dum,noise] = GetFMatF(0,[],[],0,1,type1);
                case 2
                    [dum,noise] = GetFMatF(0,[],[],0,1,type2);
                case 3
                    [dum,noise] = GetFMatF(0,[],[],0,1,type3);
                case 4
                    [dum,noise] = GetFMatF(0,[],[],0,1,type4);
                case 5
                    [dum,noise] = GetFMatF(0,[],[],0,1,type5);
                case 6
                    [dum,noise] = GetFMatF(0,[],[],0,1,type6);
                case 7
                    [dum,noise] = GetFMatF(0,[],[],0,1,type7);
                case 8
                    [dum,noise] = GetFMatF(0,[],[],0,1,type8);
                case 9
                    [dum,noise] = GetFMatF(0,[],[],0,1,type9);
                case 10
                    [dum,noise] = GetFMatF(0,[],[],0,1,type10);
                otherwise
                    disp('ERROR');
            end
            
            out = noise(randperm(size(noise,1),1),:);
            train_label = [train_label;0];
            train_set   = [train_set;out];
            
         else
             i = i - 1;
             continue;
         end

    end
Feature1 = train_set(:,3);
Feature2 = train_set(:,4);
gscatter(Feature1,Feature2,train_label)