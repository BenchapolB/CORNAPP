num = 11;
type = strcat('I:\Corn\CORN APP\Unknown\',int2str(num));
list = dir(type);
Label = [];
tester = [];
for n = 4:size(list,1)
    Label = [Label;num];
    display('processing...');
    display(strcat('Type',int2str(num)))
    path = strcat(type,'/',list(n).name);
    
    [FF] = GetWH(path);
    tester = [tester;FF];

end
close all
run