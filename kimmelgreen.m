function output=kimmelgreen(input)
[H,W,~]=size(input);
output=input;
for i=3:H-2
    for j=3:W-2
        if(mod(i,2)==0&&mod(j,2)~=0||(mod(i,2)~=0&&mod(j,2)==0))
            E1=1/(sqrt(1+(max(abs(input(i-1,j-1,2)-input(i,j,2))/2,abs(input(i+1,j+1,2)-input(i,j,2))/sqrt(2)))^2+(max(abs(input(i-1,j-1,2)-input(i-2,j-2,2))/2,abs(input(i-1,j-1,2)-input(i,j,2))/sqrt(2)))^2));
            E3=1/(sqrt(1+(max(abs(input(i-1,j+1,2)-input(i,j,2))/2,abs(input(i+1,j-1,2)-input(i,j,2))/sqrt(2)))^2+(max(abs(input(i-1,j+1,2)-input(i-2,j+2,2))/2,abs(input(i-1,j+1,2)-input(i,j,2))/sqrt(2)))^2));
            E7=1/(sqrt(1+(max(abs(input(i-1,j+1,2)-input(i,j,2))/2,abs(input(i+1,j-1,2)-input(i,j,2))/sqrt(2)))^2+(max(abs(input(i+1,j-1,2)-input(i+2,j-2,2))/2,abs(input(i+1,j-1,2)-input(i,j,2))/sqrt(2)))^2));
            E9=1/(sqrt(1+(max(abs(input(i+1,j+1,2)-input(i,j,2))/2,abs(input(i-1,j-1,2)-input(i,j,2))/sqrt(2)))^2+(max(abs(input(i+1,j+1,2)-input(i+2,j+2,2))/2,abs(input(i+1,j+1,2)-input(i,j,2))/sqrt(2)))^2));
            output(i,j,2)=input(i,j,2)*(E1*(input(i-1,j-1,2)/input(i-1,j-1,2))+E3*(input(i-1,j+1,2)/input(i-1,j+1,2))+E7*(input(i+1,j-1,2)/input(i+1,j-1,2))+E9*(input(i+1,j+1,2)/input(i+1,j+1,2)))/(E1+E3+E7+E9);
        end
    end
end


end

