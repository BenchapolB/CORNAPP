clc;
sum = [];
cnt = 1;
load('db.mat');
for i = 1:11
    for j=1:15
        model(i,j).svm= 0;
        model(i,j).nn= 0;
        model(i,j).nb= 0;
        model(i,j).dt= 0;
    end
end
tester=[];
% for i =1:10
%     n = randperm(size(db(i).type,1),1);
%     tmp = db(i).type;
%     tester = [tester;tmp(n,:)];
%     tmp(n,:) = [];
%     db_tmp(i).type = tmp;
% end
for i = 1:11
    disp(strcat(int2str(i*10),'%'));
    for fs = 1:15
        [model(i,fs).svm] = SVM(db,i,model(i,fs).svm,fs);
        [model(i,fs).nn]  = NN(db,i,model(i,fs).nn,fs);
        [model(i,fs).nb]  = NB(db,i,model(i,fs).nb,fs);
        [model(i,fs).dt]  = DT(db,i,model(i,fs).dt,fs);
    end
end
save('model.mat','model');
