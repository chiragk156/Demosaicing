function a = diamondneighbours( input,i,j )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a=zeros(1,4);
a(1)=input(i-2,j);
a(2)=input(i,j+2);
a(3)=input(i+2,j);
a(2)=input(i,j-2);

end

