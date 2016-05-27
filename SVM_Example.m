clc
close all
accuracy = [];
load('db.mat')
for a = 1:11
    accuracy = [];
    x = db(a).type;
    fs = 11;
    tp = 0;
    fp = 0;
    tn = 0;
    fn = 0;
    for n=1:10
        kFold = 10;
        num_record = 10;
        group = ceil(kFold * randperm(num_record)' / num_record);

        test_set    = [];
        test_label  = [];
        train_set   = [];
        train_label = [];
        for i=1:3
                [test_label,test_set] = GetFMatF(1,test_label,test_set,(group(i)-1)/10,group(i)/10,x,fs);
        end
        for i = 4:10
                [train_label,train_set] = GetFMatF(1,train_label,train_set,(group(i)-1)/10,group(i)/10,x,fs);
        end
        
        Loop = ceil(size(train_label,1)*0.3);
        for i = 1:Loop
            rand = randperm(11,1);

            if ( rand ~= a )
                [dum,noise] = GetFMatF(a,[],[],0,1,db(rand).type,fs);
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
                [dum,noise] = GetFMatF(1,[],[],0,1,db(rand).type,fs);

                out = noise(randperm(size(noise,1),1),:);
                test_label = [test_label;0];
                test_set   = [test_set;out];

             else
                 i = i - 1;
                 continue;
            end
        end

        svmstruct = svmtrain(train_set,train_label);
        class = svmclassify(svmstruct,test_set);
        count = 0;
        for i=1:size(class,1)
            if test_label(i,1)~=class(i,1)
                count = count+1;
                if test_label(i,1) == 0
                    fp = fp + 1;
                else
                    fn = fn + 1;
                end
            else
                if test_label(i,1) == 0
                    tn = tn + 1;
                else
                    tp = tp + 1;
                end
            end
        end
        accuracy = [accuracy,(size(class,1)-count)/size(class,1)];
    end

    sum = 0;
    for i = 1:10
        sum = sum+accuracy(i);
    end
    %disp(a);
    %disp([tp,fn;fp,tn]);
    sum =sum/10;
    disp([tp/(tp+fn),tp/(tp+fp),sum]);
    %disp(tp/(tp+fp));
end