function [ result1, result2, result3 ] = GetResult_GUI(  )
%GETRESULT_GUI Summary of this function goes here
%   Detailed explanation goes here
    load('model.mat');
    [FF] = GetWH( 'im.jpg' );
    out = [FF];
    
    WH = out(1,1:3);
    color = out(1,4:403);
    stat = out(1,404:435);
    shape = out(1,436:459);
    Area = out(1,460:461);
    WH = [WH Area];
    
    result1 = zeros(1,11);
    result2 = zeros(1,11);
    result3 = zeros(1,11);
    
    for j = 1:11;
        for i=1:15
            input = [];
            switch i
                case 1
                    input = [input;WH];
                case 2
                    input = [input;color];
                case 3
                    input = [input;stat];
                case 4
                    input = [input;shape];
                case 5
                    input = [input;WH color];
                case 6
                    input = [input;WH stat];
                case 7
                    input = [input;WH shape];
                case 8
                    input = [input;WH color stat];
                case 9
                    input = [input;WH color shape];
                case 10
                    input = [input;WH stat shape];
                case 11
                    input = [input;WH color stat shape];
                case 12
                    input = [input;color stat];
                case 13
                    input = [input;color shape];
                case 14
                    input = [input;color stat shape];
                case 15
                    input = [input;stat shape];
                    
            end
            class = svmclassify(model(j,i).svm,input);
            result1(j) = result1(j)+class;
            
            simpleclassOutputs = sim(model(j,i).nn, input');
            [c, cm, ind, per] = confusion(1, simpleclassOutputs);
            result2(j) = result2(j) + 1-c;
            
            class = NB_function(model(j,i).nb,'normal',input);
            result3(j) = result3(j) + class;

            
        end
        
    end
    disp(result1);
    disp(result2);
    disp(result3);
    
    disp(result1+result2);
    
    max = -10;
    pos = [];
    for i = 1:11
        if result1(i) > max
            max = result1(i);
            pos(1) = i;
        end
    end
    max = -10;
    for i = 1:11
        if result2(i) > max
            max = result2(i);
            pos(2) = i;
        end
    end
    %h = msgbox({int2str(pos(1)) int2str(pos(2))});
end

