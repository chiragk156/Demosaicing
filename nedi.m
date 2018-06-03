function output = nedi(input)
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
            if(mod(i,2)==0&&mod(j,2)==0)
               output(i,j,3)=input(i,j);
           else
               output(i,j,1)=input(i,j);
           end
        else
            output(i,j,2)=input(i,j);
        end
    end
end
for i=6:H-5
    for j=6:W-5
        if((mod(i,2)==0&&mod(j,2)==0)||(mod(i,2)~=0&&mod(j,2)~=0))
           %c=[input(i-1,j);input(i,j+1);input(i+1,j);input(i,j-1)];
           c=[input(i-1,j);input(i,j+1);input(i+1,j);input(i,j-1);input(i-3,j);input(i-2,j+1);input(i-1,j+2);input(i,j+3);input(i+1,j+2);input(i+2,j+1);input(i+3,j);input(i+2,j-1);input(i+1,j-2);input(i,j-3);input(i-1,j-2);input(i-2,j-1)];
           %C=[input(i-3,j),input(i-1,j+2),input(i+1,j),input(i-1,j-2);input(i-2,j+1),input(i,j+3),input(i+2,j+1),input(i,j-1);input(i-1,j),input(i+1,j+2),input(i+3,j),input(i+1,j-2);input(i-2,j-1),input(i,j+1),input(i+2,j-1),input(i,j-3)];
           C=[diamondneighbours(input,i-1,j);diamondneighbours(input,i,j+1);diamondneighbours(input,i+1,j);diamondneighbours(input,i,j-1);diamondneighbours(input,i-3,j);diamondneighbours(input,i-2,j+1);diamondneighbours(input,i-1,j+2);diamondneighbours(input,i,j+3);diamondneighbours(input,i+1,j+2);diamondneighbours(input,i+2,j+1);diamondneighbours(input,i+3,j);diamondneighbours(input,i+2,j-1);diamondneighbours(input,i+1,j-2);diamondneighbours(input,i,j-3);diamondneighbours(input,i-1,j-2);diamondneighbours(input,i-2,j-1)];
           M=4;
           R=(1/(M*M))*transpose(C)*C;
           r=(1/(M*M))*transpose(C)*c;
           if(det(R)==0)
               alpha=[1;1;1;1];
           else
               alpha=inv(R)*r;
           end
           alpha=abs(alpha);
           output(i,j,2)=(alpha(1)*input(i-1,j)+alpha(2)*input(i,j+1)+alpha(3)*input(i+1,j)+alpha(4)*input(i,j-1))/(sum(alpha));
           %output(i,j,2)=(alpha(1)*input(i-1,j)+alpha(2)*input(i,j+1)+alpha(3)*input(i+1,j)+alpha(4)*input(i,j-1)+alpha(5)*input(i-3,j)+alpha(6)*input(i-2,j+1)+alpha(7)*input(i-1,j+2)+alpha(8)*input(i,j+3)+alpha(9)*input(i+1,j+2)+alpha(10)*input(i+2,j+1)+alpha(11)*input(i+3,j)+alpha(12)*input(i+2,j-1)+alpha(13)*input(i+1,j-2)+alpha(14)*input(i,j-3)+alpha(15)*input(i-1,j-2)+alpha(16)*input(i-2,j-1))/(sum(alpha));           
           if(mod(i,2)==0&&mod(j,2)==0)
               output(i,j,3)=input(i,j);
           else
               output(i,j,1)=input(i,j);
           end
        else
            output(i,j,2)=input(i,j);
        end
    end
end


end

