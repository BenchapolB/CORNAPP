function [ shape,shape2 ] = GetShape( bw,xMajor,yMajor,xMinor,yMinor,theta,MinorAxisLength )
%GETSHAPE Summary of this function goes here
%   Detailed explanation goes here
  %%
    shape3 = [];
    shape4 = [];
    if xMajor(1) > xMajor(2)
        x1 = xMajor(2);
        x2 = xMajor(1);
    else
        x1 = xMajor(1);
        x2 = xMajor(2);
    end
    if yMajor(1) > yMajor(2)
        y1 = yMajor(2);
        y2 = yMajor(1);
    else
        y1 = yMajor(1);
        y2 = yMajor(2);
    end
    x = x2 - x1;
    y = y2 - y1;
    majx = [];
    majy = [];
    part = 10;
    if yMajor(1) < yMajor(2)
        
        for i=1:part
            majx = [majx,floor(x1+x/part*i)];
            majy = [majy,floor(y1+y/part*i)];
        end
    else
        for i=1:part
            majx = [majx,floor(x2-x/part*i)];
            majy = [majy,floor(y1+y/part*i)];
        end
    end
    shape2 = [];
    for i=1:part
        shape2 = [shape2;[majx(i) ,majy(i)]];
    end

    
    %% creath path of minor
    d = 100;
    for i =1:part-1
        xMinor = majx(i) +  [ 1.03  -1.03] * MinorAxisLength*sind(theta)/2;
        yMinor = majy(i) +  [ 1.03  -1.03] * MinorAxisLength*cosd(theta)/2;
%         line(xMinor,yMinor)
        
        x = abs(majx(i)-xMinor(1));
        y = abs(majy(i)-yMinor(1));
        x2 = abs(majx(i)-xMinor(2));
        y2 = abs(majy(i)-yMinor(2));
        minDx = [];
        minDy = [];
        minUx = [];
        minUy = [];
        if majx(i) < xMinor(1)
            %display('\down');
            for j=1:d
                minDx = [minDx,floor(majx(i)+x*j/d)];
                minDy = [minDy,floor(majy(i)+y*j/d)];
            end
        else
            %display('/down');
            for j=1:d
                minDx = [minDx,floor(majx(i)-x*j/d)];
                minDy = [minDy,floor(majy(i)+y*j/d)];  
            end
        end
        
        if majx(i) > xMinor(2)
            %display('\up');
            for j=1:d
                minUx = [minUx,floor(majx(i)-x*j/d)];
                minUy = [minUy,floor(majy(i)-y*j/d)];
            end
        else
            %display('/up');
            for j=1:d
                minUx = [minUx,floor(majx(i)+x*j/d)];
                minUy = [minUy,floor(majy(i)-y*j/d)];  
            end
        end
        
        
        %% find length of minor
        found = 0;
        %down
        for k = d:-1:1
%             rectangle('Position',[minDx(k)-2,minDy(k)-2,4,4],'EdgeColor','G','LineWidth',1) ;
            minDx(k) = round(minDx(k));
            minDy(k) = round(minDy(k));
            
            if minDy(k) <= 0 || minDx(k) <= 0 || minDy(k) > size(bw,1) || minDx(k) > size(bw,2)
                continue;
            end
            if bw(minDy(k),minDx(k)) == 1
               % if sum(sum(bw(minx(k)-1:minx(k)+1,miny(k)-1:miny(k)+1))) <=5
                    shape3 = [shape3;[minDx(k),minDy(k)],i,abs(minDy(k)-floor(yMajor(1)))];
                    found = 1;
                    break;
                %end
            end
        end
        if found == 0
            shape3 = [shape3;0 0 i 0];
        end
%         for kk = 1:k
%             
%             rectangle('Position',[minDx(kk)-2,minDy(kk)-2,4,4],'EdgeColor','G','LineWidth',1) ;
%         end
        found = 0;
        %up
        for k = d:-1:1
%             rectangle('Position',[minUx(k)-2,minUy(k)-2,4,4],'EdgeColor','G','LineWidth',1) ;
            minUx(k) = round(minUx(k));
            minUy(k) = round(minUy(k));
            if minUy(k) <= 0 || minUx(k) <= 0 || minUy(k) > size(bw,1) || minUx(k) > size(bw,2)
                continue;
            end
            if bw(minUy(k),minUx(k)) == 1
               % if sum(sum(bw(minx(k)-1:minx(k)+1,miny(k)-1:miny(k)+1))) <=5
                    shape4 = [shape4;[minUx(k),minUy(k)],i,abs(minDy(k)-floor(yMajor(1)))];
                    found = 1;
                    break;
                %end
            end
        end
        if found == 0
            shape4 = [shape4;0 0 i 0];
        end%         for kk = 1:k
%             
%             rectangle('Position',[minUx(kk)-2,minUy(kk)-2,4,4],'EdgeColor','G','LineWidth',1) ;
%         end

            
    end
    shape = [shape3;shape4];
    dev1=  zeros(1,18);
    for i = 2:9
        if shape(i,4) > shape(i-1,4)
            dev1(i-1) = 1;
        elseif shape(i,4) < shape(i-1,4)
            dev1(i-1) = -1;
        else
            dev1(i-1) = 0;
        end
    end
    for i = 11:18
        if shape(i,4) > shape(i-1,4)
            dev1(i-1) = 1;
        elseif shape(i,4) < shape(i-1,4)
            dev1(i-1) = -1;
        else
            dev1(i-1) = 0;
        end
    end
   
    dev2 = zeros(1,18);
    for i = 2:8
        if dev1(i) ~= dev1(i-1)
            dev2(i-1) = 1;
        end
    end
    for i = 11:17
        if dev1(i) ~= dev1(i-1)
            dev2(i-1) = 1;
        end
    end
    c = 0;
    for i =1:size(dev2,2)
        if dev2(i) == 1
            c = c+1;
        end
    end
    shape = [shape(:,4)' c mean(shape3(:,4)) mean(shape4(:,4)) std(shape3(:,4)) std(shape4(:,4))];
    shape2 = [shape3 ;shape4];
end
           
      
