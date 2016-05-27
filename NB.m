function [ struct ] = NB( db,a,struct,fs )
%NB Summary of this function goes here
%   Detailed explanation goes here
    typenum = db(a).type;
    [train_label,train_set]=GetFMatF(1,[],[],0,1,typenum,fs);
    Loop = floor(size(train_label,1)*0.3);
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
    
    x = train_set;
    y = train_label;
    uni = unique(y);
    ni = size(x,2);
    for i = 1:2
        fy(i) = sum(double(y==uni(i)))/length(y);
    end
    struct.x = x;
    struct.y = y;
    struct.ni = ni;
    struct.fy = fy;
end

