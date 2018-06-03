function output = suggestedalgo(input,image)
%output=green(input,image);
% figure();
% imshow(uint8(output(:,:,2)));
output=nedi(input);
output=kimmel(output);

end

