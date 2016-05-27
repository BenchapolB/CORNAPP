c = 0;
a = '3';
for i = 1:100
    x = simulate(a);
    if strcmp(x,'3')
        c = c+1;
    end
end
disp(c);