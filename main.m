clear
clc
image_path = input('Enter image path: ','s');
image = double(imread(image_path));

figure();
imshow(uint8(image)),title('original');

%RGB to bayer and padding of 2
bayerimage = rgbtobayer(image);
padding = 2;
paddedimage = padarray(bayerimage,[padding padding],0,'both');
figure();
imshow(uint8(paddedimage)),title('bayer');

%linear Interpolation
linearIntImage=linearInterpolation(paddedimage);
figure();
imshow(uint8(linearIntImage)),title('Linear Interpolated');

%hue
huebased=hue(paddedimage);
figure();
imshow(uint8(huebased)),title('hue based');

%gradient
gradientBasedImage=gradientBased(paddedimage);
figure();
imshow(uint8(gradientBasedImage)),title('gradient based');

%adaptive
adaptivecolor=AdaptiveColorPlane(paddedimage);
figure();
imshow(uint8(adaptivecolor)),title('adaptive color');

%kimmel and NEDI
suggestedImage=suggestedalgo(paddedimage,image);
figure();
imshow(uint8(suggestedImage)),title('kimmel and NEDI');

%Wu's LMMSE
wu=demosaicWu(paddedimage);
figure();
imshow(uint8(wu)),title('LMMSE');

[H,W,~]=size(suggestedImage);
[h,w,~]=size(image);


%PSNR's
wupnsr=psnr(uint8(image(3:h-2,3:w-2)),uint8(wu(5:H-4,5:W-4)))
kimmelNEDI=psnr(uint8(image(3:h-2,3:w-2)),uint8(suggestedImage(5:H-4,5:W-4)))
grad=psnr(uint8(image(3:h-2,3:w-2)),uint8(gradientBasedImage(5:H-4,5:W-4)))
adap=psnr(uint8(image(3:h-2,3:w-2)),uint8(adaptivecolor(5:H-4,5:W-4)))
hue=psnr(uint8(image(3:h-2,3:w-2)),uint8(huebased(5:H-4,5:W-4)))
lin=psnr(uint8(image(3:h-2,3:w-2)),uint8(linearIntImage(5:H-4,5:W-4)))

%inbuilt
figure();
inbuilt=demosaic(uint8(paddedimage),'rggb');
psnrinbuilt=psnr(uint8(image(3:h-2,3:w-2)),uint8(inbuilt(5:H-4,5:W-4)))
imshow(uint8(inbuilt)),title('inbuilt');