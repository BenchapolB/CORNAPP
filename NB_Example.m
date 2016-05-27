clc
close all
clear
load('db.mat');
accuracy = [];
distr ='normal';
a =1;
for a = 1:11
    accuracy = [];
    fs = 11;
    dbx = db(a).type;
    cm_total = [0,0;0,0];
    for m = 1:10
        P = [];
        pv = [];
        kFold = 10;
        num_record = 10;
        group = ceil(kFold * randperm(num_record)' / num_record) ;
        test_set = [];
        test_label = [];
        train_set = [];
        train_label = [];
        for i=1:3
                [test_label,test_set] = GetFMatF(1,test_label,test_set,(group(i)-1)/10,group(i)/10,dbx,fs);
        end
        for i = 4:10
                [train_label,train_set] = GetFMatF(1,train_label,train_set,(group(i)-1)/10,group(i)/10,dbx,fs);
        end


        Loop = floor(size(train_label,1)*0.3);
        for i = 1:Loop
            rand = randperm(11,1);
            if ( rand ~= a )
                [dum,noise] = GetFMatF(0,[],[],0,1,db(rand).type,fs);
                out = noise(randperm(size(noise,1),1),:);
                train_label = [train_label;0];
                train_set   = [train_set;out];

             else
                 i = i - 1;
                 continue;
             end

        end

        Loop = floor(size(test_label,1)*0.5);
        for i = 1:Loop
            rand = randperm(11,1);
            if ( rand ~= a )
                [dum,noise] = GetFMatF(0,[],[],0,1,db(rand).type,fs);
                out = noise(randperm(size(noise,1),1),:);
                test_label = [test_label;0];
                test_set   = [test_set;out];

             else
                 i = i - 1;
                 continue;
             end

        end

        y = train_label;
        x = train_set;
        v = test_label;
        u = test_set;
        unique = [0;1];
        nc = length(unique);
        ni = size(x,2);
        ns = length(v);
        
        
        for i = 1:nc
            fy(i) = sum(double(y==unique(i)))/length(y);
        end

        switch distr
            case 'normal'
                for i = 1:nc
                    xi = x((y==unique(i)),:);
                    mu(i,:)=mean(xi,1);
                    sigma(i,:) = std(xi,1);
                end
                for j = 1:ns
                    fu = normcdf(ones(nc,1)*u(j,:),mu,sigma);
                    P(j,:) = fy.*prod(fu,2)';
                end

            case 'kernel'
                for i=1:nc
                    for k=1:ni
                        xi=x(y==unique(i),k);
                        ui = u(:,k);
                        fuStruct(i,k).f = ksdensity(xi,ui);
                    end
                end

                for i =1:ns
                    for i=1:nc
                        for k=1:ni
                            fu(j,l) = fuStruct(j,k).f(i);
                        end
                    end
                    P(i,:) = fy.*prod(fu,2)';
                end

            otherwise
                disp('invalid distribution stated')
                return
        end

        [pv0,id] = max(P,[],2);
        for i=1:length(id)
            pv(i,1)= unique(id(i));
        end

        confMat = myconfusionmat(v,pv);
        cm_total = cm_total+confMat;
        conf = sum(pv==v)/length(pv);
        accuracy = [accuracy, conf];
    %     disp(['accuracy = ',num2str(conf*100),'%'])
    %     disp(confMat);
    % disp([size(train_label,1),size(test_label,1)]);
    end

    sum_acc = 0;
    for i = 1:10
        sum_acc = sum_acc+accuracy(i);
    end
    %disp(a);
    sum_acc = sum_acc/10;
    cm_total = rot90(cm_total);
    cm_total = rot90(cm_total);
    
    tp = cm_total(1,1);
    fn = cm_total(1,2);
    fp = cm_total(2,1);
    tn = cm_total(2,2);
    disp([tp/(tp+fn),tp/(tp+fp),sum_acc]);

end