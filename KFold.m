clc;
num = 1;
prompt_data = type1;

%display(size(prompt_data,1));

kFold = 10;
%type = strcat('C:\Users\Benn\Documents\MATLAB\Dataset',int2str(num));
%list = dir(type);
    
%display(size(list,1));
%for n = 1:size(list,1)
%    display(list(n).name);
%end
num_record = size(prompt_data,1);
group = ceil(kFold * randperm(num_record)' / num_record) ;
cell_train_test = cell(kFold,2); 
    
for i=1:kFold
    train_set = [];
    test_set = [];
    test_index = 1;
    train_index = 1;
        
    for j=1:num_record
        if group(j,1) == i
            test_set(test_index,:) = prompt_data(j,:);
            test_index = test_index + 1;
        else
            train_set(train_index,:) = prompt_data(j,:);
            train_index = train_index + 1;
        end            
    end
     
    %store in cell
    cell_train_test(i,1) = {train_set}; 
    cell_train_test(i,2) = {test_set};  
end 
for i = 1:kFold
    display(cell_train_test(i,1));
end
for i = 1:kFold
    display(cell_train_test(i,2));
end

