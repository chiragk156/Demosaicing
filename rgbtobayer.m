function output = rgbtobayer( input )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[H,W,A] = size(input);
for i=1:H
    for j=1:W
        if mod(i,2)==0
           if mod(j,2)==0
               output(i,j)=input(i,j,3);
           else
               output(i,j)=input(i,j,2);
           end
        else
            if mod(j,2)==0
               output(i,j)=input(i,j,2);
           else
               output(i,j)=input(i,j,1);
           end
        end
    end
end
end

