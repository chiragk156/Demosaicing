function output = green(input,image)
padding = 2;
paddedoriimage = padarray(image,[padding padding],0,'both');
output=paddedoriimage;
output(:,:,1)=0;
output(:,:,3)=0;
[H,W,~]=size(output);
for i=2:H-2
    for j=2:W-2
        if(mod(i,2)==0)
            if(mod(j,2)==0)
                output(i,j,3)=input(i,j);
            end
        else
            if(mod(j,2)~=0)
                output(i,j,1)=input(i,j);
            end
        end
    end
end
end