clc
close all
clear
load('db.mat');
accuracy = [];
a = 1;
fs = 11;
[training_label,training_set]=GetFMatF('1',[],[],0,0.5,db(a).type,fs);
Loop = floor(size(training_label,1)*0.7);
if Loop <3
    Loop = 3;
end
for i = 1:Loop
    rand = randperm(10,1);
    if ( rand ~= a )
        [dum,noise] = GetFMatF('0',[],[],0,1,db(rand).type,fs);
        out = noise(randperm(size(noise,1),1),:);
        training_label = [training_label;'0'];
        training_set   = [training_set;out];

     else
         i = i - 1;
         continue;
     end

end

[test_label,test_set]=GetFMatF('1',[],[],0.5,1,db(a).type,fs);

x = training_set;  %# mixed continous/discrete data
y = training_label;
%# train classification decision tree
t = classregtree(x, y, 'method','classification', 'prune','off');
view(t)

%# test
yPredicted = eval(t, x);
cm = confusionmat(cellstr(y),yPredicted);           %# confusion matrix
N = sum(cm(:));
disp(cm);
err = ( N-sum(diag(cm)) ) / N;             %# testing error
acc = 1- err;
% %# prune tree to avoid overfitting
 tt = prune(t, 'level',2);
%view(tt)
% 
% %# predict a new unseen instance
% inst = [33 4 78 NaN];
 prediction = eval(tt, test_set) ;   %# pred = 'Japan'





