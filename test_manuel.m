clear all
close all
# Squeletisation avec matlab

I = zeros(100,100)
for y=25:75
  I(y,y) = 1;
  I(100-y,y) = 1;
endfor

##imshow(I, 'InitialMagnification', 'fit');

##IMG_THIN = squeletisation.skl(I, I);
##figure;imshow(IMG_THIN);title('Squeletisation');

img_minutiae = minutiae.calcul2(I);

##imshow(img_minutiae);title('Minutiae');