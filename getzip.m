clc

clear all
load('db.mat');
a = 7;
[dumb2,dumb,out] = GetFMatF(a,[],[],0,1,db(a).type,11);
WH = out(1,1:5);
color = out(1,6:405);
stat = out(1,406:437);
shape = out(1,438:455);