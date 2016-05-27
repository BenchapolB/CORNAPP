function [ class ] = DT_function( struct,input )
%DT_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
    yPredicted = eval(struct, input);
    cm = confusionmat(cellstr(y),yPredicted);           %# confusion matrix
    N = sum(cm(:));
    err = ( N-sum(diag(cm)) ) / N;             %# testing error
    acc = 1- err;
    class = acc;

end

