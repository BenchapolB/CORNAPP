for i =1:11
    [l,bucket(i).type] = GetFMat(i);
end
beep on
for i = 1:5
    beep
end
save('bucket.mat','bucket');