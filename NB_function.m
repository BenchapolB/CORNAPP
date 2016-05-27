function [ class ] = NB_function( struct,distr ,input)
%NB_FUNCTION Summary of this function goes here
        %   Detailed explanation goes here
    
    x = struct.x;
    y = struct.y;
    ni = struct.ni;
    fy = struct.fy;
    uni = [0;1];
    switch distr
        case 'normal'
            for i = 1:2
                xi = x((y==uni(i)),:);
                mu(i,:)=mean(xi,1);
                sigma(i,:) = std(xi,1);
            end
            for j = 1:1
                fu = normcdf(ones(2,1)*input(j,:),mu,sigma);
                P(j,:) = fy.*prod(fu,2)';
            end
        case 'kernel'
            for i=1:2
                for k=1:ni
                    xi=x(y==uni(i),k);
                    ui = input(:,k);
                    fuStruct(i,k).f = ksdensity(xi,ui);
                end
            end

            for i =1:ns
                for i=1:2
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
        pv(i,1)= uni(id(i));
    end
    class = pv;
    confMat = myconfusionmat(1,pv);
    conf = sum(pv==1)/length(pv);
    

end

