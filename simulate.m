function [ output, result ] = simulate( input )
%SIMULATE Summary of this function goes here
%   Detailed explanation goes here
tic;
load('db_result.mat');
    switch input
        case '1'
            grade = 1;
        case '2s'
            grade = 2;
        case '2'
            grade = 3;
        case '3s'
            grade = 4;
        case '3'
            grade = 5;
    end
    criteria =   [3 12 0 0; ...
                  6 24 3 3;...
                  12 24 3 3;...
                  18 48 3 3;...
                  24 48 3 3];
    ans = [];
    edge = 0;
    data = [db_result(1).type db_result(1).type db_result(1).type];
    pick = randperm(size(data,2),criteria(grade,1));
    for i = 1:criteria(grade,1)-edge
        ans = [ans data(pick(i))];
    end
    for i = 1:criteria(grade,2)-edge
        data = db_result(2).type;
        result = data(randperm(size(data,2),1));
        ans = [ans result];
    end
    for i = 1:criteria(grade,3)-edge   
        data = db_result(6).type;
        result = data(randperm(size(data,2),1));
        ans = [ans result];
    end
    data = [db_result(3).type db_result(8).type db_result(9).type db_result(10).type];
    pick = randperm(size(data,2),criteria(grade,3));
    for i = 1:criteria(grade,3)-edge
        ans = [ans data(pick(i))];
    end
    
    data = [db_result(11).type];
    pick = randperm(size(data,2),300-size(ans,2));
     for i = 1:(300-size(ans,2))
         ans = [ans 11];
            
     end
     toc;
     result = [0 0 0 0];
    for i =1:size(ans,2)
        if ismember(ans(i),[1])
            result(1) = result(1)+1;
        elseif ans(i) == 2
            result(2) = result(2)+1;
        elseif ans(i) == 6
            result(3) = result(3)+1;
        elseif ismember(ans(i),[3,8,9,10])
            result(4) = result(4)+1;
        end
    end
    result = double(result);
%     disp(result);
%     grade = 0;
%     prob = [0 0 0 0 0];
%     h = 0.8;
%     error = 2;
%     check = zeros(4,5);
% %     check grade1
%     for i = 1:4
%         if result(i) <= criteria(1,i)+error
%             prob(1) = prob(1)+1;
%         end
%         check(i,1) = check(i,1)+prob(1);
%     end        
% %         check grade2s
%     for i = 1:4
%         found = 0;
%         if i == 3 
%             if result(3) > criteria(1,3)+error
%                prob(2) = prob(2)+h;
%                found = 1;
%             end
%         end
%         if result(i) <= criteria(2,i)+error && found == 0
%             prob(2) = prob(2)+double(result(i))/(criteria(2,i)+error);
%         end
%         check(i,2) = check(i,2)+prob(2);
%     end 
% %     check grade2
%     for i = 1:4
%         found = 0;
%         if i == 3 
%             if result(3) > criteria(1,3)+error
%                prob(3) = prob(3)+h;
%                found = 1;
%             end
%         end
%         if i == 4 
%             if result(4) > criteria(2,4)+error
%                prob(3) = prob(3)+h;
%                found = 1;
%             end
%         end
%         if result(i) <= criteria(3,i)+error && found == 0
%             prob(3) = prob(3)+result(i)/(criteria(3,i)+error);
%         end
%         check(i,3) = check(i,3)+prob(3);
%     end 
% %     check grade3s
%     for i = 1:4
%         found = 0;
%         if i == 2 
%             if result(2) > criteria(2,2)+error
%                prob(4) = prob(4)+h;
%                found = 1;
%            
%             end
%         end
%         if i == 3 
%             if result(3) > criteria(1,3)+error
%                prob(4) = prob(4)+h;
%                found = 1;
%            
%             end
%         end
%         if i == 4 
%             if result(4) > criteria(2,4)+error
%                prob(4) = prob(4)+h;
%                found = 1;
%             
%             end
%         end
%         if result(i) <= criteria(4,i)+error && found == 0
%             prob(4) = prob(4)+result(i)/(criteria(4,i)+error);
%         end
%         check(i,4) = check(i,4)+prob(4);
%     end 
% %     check grade3
%     for i = 1:4
%         found = 0;
%         if i == 1 
%             if result(1) > criteria(4,1)+error
%                prob(5) = prob(5)+h;
%                found = 1;
%             end
%         end
%         if i == 2 
%             if result(2) > criteria(3,2)+error
%                prob(5) = prob(5)+h;
%                 found = 1;
%             end
%         end
%         if i == 3 
%             if result(3) > criteria(1,3)+error
%                prob(5) = prob(5)+h;
%                found = 1;
%             end
%         end
%         if i == 4 
%             if result(4) > criteria(2,4)+error
%                prob(5) = prob(5)+h;
%                found = 1;
%             end
%         end
%         if result(i) <= criteria(4,i)+error && found == 0
%             prob(5) = prob(5)+result(i)/(criteria(5,i)+error);
%         end
%         check(i,5) = check(i,5)+prob(5);
%     end 
%     for i=4:-1:2
%         for j = 1:5
%             check(i,j) = check(i,j) - check(i-1,j);
%         end
%     end
    dist = [0 0 0 0 0];
    for  i = 1:5
        for j = 1:4
            if j==1
                dist(i) = dist(i)+abs(result(j)-criteria(i,j));
            else
                dist(i) = dist(i)+abs(result(j)-criteria(i,j));
        end
        end
    end
    disp(dist);
    disp(result);
    disp(criteria);
    [max_prob,grade] = min(dist);
    switch grade
        case 1
            output = '1';
        case 2
            output = '2s';
        case 3
            output = '2';
        case 4
            output = '3s';
        case 5
            output = '3';
        case 6
            disp('reject');
    end
end
    

