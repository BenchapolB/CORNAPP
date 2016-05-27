function [ struct ] = SVM( db,a,struct,fs )

    typenum = db(a).type;  
    [train_label,train_set] = GetFMatF(1,[],[],0,1,typenum,fs);

    Loop = ceil(size(train_label,1)*0.3);
    if Loop <=3
        Loop = 5;
    end
    for i = 1:Loop
        if size(db,2) == 2
            if a == 1
                rand = 2;
            else
                rand = 1;
            end
        else
            rand = randperm(10,1);
        end
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
    struct = svmtrain(train_set,train_label);
    
    disp(size(train_set));
    disp(size(train_label));
    
    
end

