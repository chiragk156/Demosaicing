function output = gaussian(sigma,size)
output=zeros(2*size+1,2*size+1);
i=0;

for x=-size:size
    i=i+1;j=0;
    for y=-size:size
        j=j+1;
        output(i,j)=exp(-(x^2+y^2)/(2*sigma^2))/sqrt(2*pi*sigma*sigma);
    end
end
a=sum(sum(output));
output=output/a;

end

