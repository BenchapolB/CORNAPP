clc;
load('model.mat');
load('modelgb.mat');
load('bucket.mat')
for z = 1:11
    tester = bucket(z).type;
    x = size(tester,1);
    tmp = [];
    for k = 1:x
        

        result = zeros(1,size(model,1));
        result2 = zeros(1,size(model,1));
        result3 = zeros(1,size(model,1));

        for j = 1:size(model,1);
            for i=1:15

                [lab,input] = GetFMatF(j,[],[],0,1,tester(k,:),i) ;

                    class = svmclassify(model(j,i).svm,input);
                    result(j) = result(j)+class;

                    simpleclassOutputs = sim(model(j,i).nn, input');
                    [c, cm, ind, per] = confusion(1, simpleclassOutputs); 
                    result2(j) = result2(j) + 1-c;

                    class = NB_function(model(j,i).nb,'normal',input);
                    result3(j) = result3(j) + class;
            end
        end

         total = result+result2;
         total(4) = 0;
        total(7) = 0;
        [x,result] = max(total);
        tmp = [tmp result];
        disp(strcat(int2str(z),'bad ans=type',int2str(result),' score=',int2str(x)));
        
    end
    db_result(z).type = tmp;
end
save('db_result.mat','db_result');