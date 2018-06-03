function output  = linearInterpolation( input )
[H,W]=size(input);
output=zeros(H,W,3);
for i=3:H-2
    for j=3:W-2
        if (mod(i,2)==1)
            if(mod(j,2)==1)
                output(i,j,1)=input(i,j);
                output(i,j,2)=(input(i+1,j)+input(i-1,j)+input(i,j-1)+input(i,j+1))/4;
                output(i,j,3)=(input(i+1,j+1)+input(i-1,j-1)+input(i+1,j-1)+input(i-1,j+1))/4;
            else
                output(i,j,2)=input(i,j);
                output(i,j,1)=(input(i,j-1)+input(i,j+1))/2;
                output(i,j,3)=(input(i+1,j)+input(i-1,j))/2;
            end
        else
            if(mod(j,2)==1)
                output(i,j,2)=input(i,j);
                output(i,j,3)=(input(i,j-1)+input(i,j+1))/2;
                output(i,j,1)=(input(i+1,j)+input(i-1,j))/2;   
            else
                output(i,j,3)=input(i,j);
                output(i,j,2)=(input(i+1,j)+input(i-1,j)+input(i,j-1)+input(i,j+1))/4;
                output(i,j,1)=(input(i+1,j+1)+input(i-1,j-1)+input(i+1,j-1)+input(i-1,j+1))/4; 
            end
        end
    end
end
                
                


end

