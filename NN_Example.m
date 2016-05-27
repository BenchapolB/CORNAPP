clc
close all
accuracy = [];
load('db.mat');
for a = 1:11
    accuracy = [];
    x = db(a).type;
    fs = 11;
    cm_total = [0,0;0,0];
    for m=1:10
        kFold = 10;
        num_record = 10;
        group = ceil(kFold * randperm(num_record)' / num_record) ;

        test_set = [];
        test_label = [];
        train_set = [];
        train_label = [];
        for i=1:3
                [test_label,test_set] = GetFMatF(1,test_label,test_set,(group(i)-1)/10,group(i)/10,x,fs);
        end
        for i = 4:10
                [train_label,train_set] = GetFMatF(1,train_label,train_set,(group(i)-1)/10,group(i)/10,x,fs);
        end


        Loop = floor(size(train_label,1)*0.3);
        for i = 1:Loop
            rand = randperm(10,1);
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
            rand = randperm(10,1);
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

        train_target = train_label;
        train_input  = train_set;

        net = newpr(train_input', train_target', 1);

        net.trainParam.showWindow = false;
        net.trainParam.showCommandLine = false;

        net.trainParam.show = 1;
        net = train(net, train_input', train_target');

        test_target = test_label;
        test_input  = test_set;

        simpleclassOutputs = sim(net, test_input');
        [c, cm, ind, per] = confusion(test_target', simpleclassOutputs);
        accuracy = [accuracy,1-c];
        cm_total = cm_total+cm;
    end
    sum = 0;
    for i = 1:10
        sum = sum+accuracy(i);
    end
    cm_total = rot90(cm_total);
    cm_total = rot90(cm_total);
    tp = cm_total(1,1);
    fn = cm_total(1,2);
    fp = cm_total(2,1);
    tn = cm_total(2,2);
    
    
    %disp(a);
    sum =sum/10;
    disp([tp/(tp+fn),tp/(tp+fp),sum]);
     %disp(cm_total);
    %disp(sum);
end