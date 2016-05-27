function [Label,FMat,out] = GetFMatF(num,Label,FMat,S,E,typenum,feature_selection)

    t = size(typenum);
    S = round(t*S)+1;
    E = round(t*E);
    
    for n = S:E
        Label = [Label;num];
        out = typenum(n,:);
        WH = out(1,1:3);
        color = out(1,4:403);
        stat = out(1,404:435);
        shape = out(1,436:459);
        Area = out(1,460:461);
        WH = [WH Area];
        switch feature_selection
            case 1
                FMat = [FMat;WH];
            case 2
                FMat = [FMat;color];
            case 3
                FMat = [FMat;stat];
            case 4
                FMat = [FMat;shape];
            case 5
                FMat = [FMat;WH color];
            case 6
                FMat = [FMat;WH stat];
            case 7
                FMat = [FMat;WH shape];
            case 8
                FMat = [FMat;WH color stat];
            case 9
                FMat = [FMat;WH color shape];
            case 10
                FMat = [FMat;WH stat shape];
            case 11
                FMat = [FMat;WH color stat shape];
            case 12
                FMat = [FMat;color stat];
            case 13
                FMat = [FMat;color shape];
            case 14
                FMat = [FMat;color stat shape];
            case 15
                FMat = [FMat;stat shape];

        end
    end
end

