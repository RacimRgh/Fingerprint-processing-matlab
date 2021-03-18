##IMG_ORG = imread('ED_data/101_1.tif');
close all
clear all

IMG_ORG = imread('ED_data/Empreinte1.bmp');

# Afficher l'image originale
subplot(2, 1, 1);
imshow(IMG_ORG);

# Calcul du seuil pour transformer l'image gris en image binaire
seuil = graythresh(IMG_ORG)
# Binarisation
IMG_BIN = not(im2bw(IMG_ORG, seuil));
##IMG_BIN = im2bw(IMG_ORG, 0.6);

# Afficher l'image binaire
subplot(2, 1, 2);
imshow(IMG_BIN);

# Squeletisation avec l'algorithme
##IMG_THIN=~bwmorph(IMG_BIN,'thin',Inf);
##figure;imshow(IMG_THIN);title('Thinned Image');

# Squeletisation avec matlab
IMG_THIN = squeletisation.skl(IMG_ORG, IMG_BIN);
figure;imshow(IMG_THIN);title('Squeletisation');

img_minutiae = minutiae.calcul(IMG_THIN)

figure;imshow(img_minutiae);title('Minutiae');