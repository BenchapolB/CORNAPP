clc;

sum = [];
cnt = 1;
load('db.mat');
bad_type = [];
for i = 1:10
    bad_type = [bad_type;db(i).type];
end
good_type = db(11).type;
db_tmp(1).type = bad_type;
db_tmp(2).type = good_type;
for i = 1:2
    for j=1:15
        modelgb(i,j).svm= 0;
        modelgb(i,j).nn= 0;
        modelgb(i,j).nb= 0;
        modelgb(i,j).dt= 0;
    end
end

for i = 1:2 
    disp(strcat(int2str(i*10),'%'));
    for fs = 1:15
        [modelgb(i,fs).svm] = SVM(db_tmp,i,modelgb(i,fs).svm,fs);
        [modelgb(i,fs).nn]  = NN(db_tmp,i,modelgb(i,fs).nn,fs);
        [modelgb(i,fs).nb]  = NB(db_tmp,i,modelgb(i,fs).nb,fs);
        [modelgb(i,fs).dt]  = DT(db_tmp,i,modelgb(i,fs).dt,fs);
    end
end
save('modelgb.mat','modelgb');
