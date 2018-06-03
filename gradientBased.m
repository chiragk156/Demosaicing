function output = gradientBased(input)
[H,W]=size(input);
output=zeros(H,W,3);
for i=3:H-2
    for j=3:W-2
        if (mod(i,2)==1 && mod(j,2)==1)||(mod(i,2)==0 && mod(j,2)==0)
            alpha = abs((input(i,j-2)+input(i,j+2))/2-input(i,j));
            beta= abs((input(i-2,j)+input(i+2,j))/2-input(i,j));
            if(alpha<beta)
                output(i,j,2)=(input(i,j-1)+input(i,j+1))/2;
            elseif(alpha>beta)
                output(i,j,2)=(input(i-1,j)+input(i+1,j))/2;
            else
                output(i,j,2)=(input(i-1,j)+input(i+1,j)+input(i,j-1)+input(i,j+1))/4;
            end
        else
            output(i,j,2)=input(i,j);
        end
    end
end
for i=3:H-2
    for j=3:W-2
        if (mod(i,2)==1 && mod(j,2)==0)
            output(i,j,1)=( (input(i,j-1)-output(i,j-1,2)) + (input(i,j+1)-output(i,j+1,2)) )/2 + output(i,j,2);
            output(i,j,3)=( (input(i-1,j)-output(i-1,j,2)) + (input(i+1,j)-output(i+1,j,2)) )/2 + output(i,j,2);
        elseif((mod(i,2)==0 && mod(j,2)==1))
            output(i,j,3)=( (input(i,j-1)-output(i,j-1,2)) + (input(i,j+1)-output(i,j+1,2)) )/2 + output(i,j,2);
            output(i,j,1)=( (input(i-1,j)-output(i-1,j,2)) + (input(i+1,j)-output(i+1,j,2)) )/2 + output(i,j,2);
        elseif((mod(i,2)==0 && mod(j,2)==0))
            output(i,j,3)=input(i,j);
            output(i,j,1)=( (input(i-1,j-1)-output(i-1,j-1,2)) + (input(i+1,j+1)-output(i+1,j+1,2))+ (input(i-1,j+1)-output(i-1,j+1,2)) + (input(i+1,j-1)-output(i+1,j-1,2)) )/4 + output(i,j,2);
        elseif((mod(i,2)==1 && mod(j,2)==1))
            output(i,j,1)=input(i,j);
            output(i,j,3)=( (input(i-1,j-1)-output(i-1,j-1,2)) + (input(i+1,j+1)-output(i+1,j+1,2))+ (input(i-1,j+1)-output(i-1,j+1,2)) + (input(i+1,j-1)-output(i+1,j-1,2)) )/4 + output(i,j,2);
        end
    end
end

end

