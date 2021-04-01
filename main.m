close all
clear all
##
### Traitement de l'image 1
IMG1 = imread('ED_data/ED_3_6_originale.png'); #lecture
####IMG1 = imread('ED_data/101_1.tif'); #lecture
###------------------------------------------------------------------------------
### Afficher l'image originale
##subplot(2, 1, 1);
##imshow(IMG1);
##h = zeros(256);
##[nl, nc] = size(IMG1);
##for x=1:nl
##  for y=1:nc
##    h(IMG1(x,y)+1) = h(IMG1(x,y)+1) + 1;
##  endfor
##endfor
##figure;plot(h)
###------------------------------------------------------------------------------
### Calcul du seuil pour transformer l'image gris en image binaire
seuil1 = graythresh(IMG1);
###------------------------------------------------------------------------------
### Binarisation
IMG_BIN1 = not(im2bw(IMG1, seuil1));
###------------------------------------------------------------------------------
### Afficher l'image binaire
##subplot(2, 1, 2);
##imshow(IMG_BIN1);
###------------------------------------------------------------------------------
### Squeletisation avec matlab
IMG_THIN1=bwmorph(IMG_BIN1,'thin',Inf);
figure;imshow(IMG_THIN1);title('Squeletisation avec matlab');
###------------------------------------------------------------------------------
### Squeletisation avec l'algorithme
##IMG_THIN1 = squeletisation.skl(IMG1, IMG_BIN1);
###------------------------------------------------------------------------------
figure;imshow(IMG_THIN1);title('Squeletisation avec algorithme de Hilditch');
###------------------------------------------------------------------------------
### Calcul des minuties: bifurcations et terminaisons
[img_minutiae1, bif1, ter1] = minutiae.calcul2(IMG_THIN1);
###------------------------------------------------------------------------------
####db1 = sum(bif1(:) == 1)
####dt1 = sum(ter1(:) == 1)
##
##
### Traitement de l'image 2
##IMG2 = imread('ED_data/ED_5_1_originale.png'); #lecture
####IMG2 = imread('ED_data/101_2.tif'); #lecture
###------------------------------------------------------------------------------
### Afficher l'image originale
##figure;
##subplot(2, 1, 1);
##imshow(IMG2);
###------------------------------------------------------------------------------
### Calcul du seuil pour transformer l'image gris en image binaire
##seuil2 = graythresh(IMG1);
###------------------------------------------------------------------------------
### Binarisation
##IMG_BIN2 = not(im2bw(IMG2, seuil2));
###------------------------------------------------------------------------------
### Afficher l'image binaire
##subplot(2, 1, 2);
##imshow(IMG_BIN2);
###------------------------------------------------------------------------------
### Squeletisation avec matlab
##IMG_THIN2 = bwmorph(IMG_BIN2,'thin',Inf);
###------------------------------------------------------------------------------
### Squeletisation avec l'algorithme
####IMG_THIN2 = squeletisation.skl(IMG2, IMG_BIN2);
###------------------------------------------------------------------------------
##figure;imshow(IMG_THIN2);title('Squeletisation');
###------------------------------------------------------------------------------
### Calcul des minuties: bifurcations et terminaisons
##[img_minutiae2, bif2, ter2] = minutiae.calcul2(IMG_THIN2);
###------------------------------------------------------------------------------
####db2 = sum(bif2(:) == 1)
####dt2 = sum(ter2(:) == 1)
##
### Comparaison des bifurcations
####dh1 = minutiae.hausdorff(bif1, bif2)
####dh2 = minutiae.hausdorff(ter1, ter2)
####dh1 = minutiae.compare_minuties(bif1, bif2)
####dh2 = minutiae.compare_minuties(ter1, ter2)
##dh1 = minutiae.compare_minuties(bif1, ter1)
##dh2 = minutiae.compare_minuties(bif2, ter2)
