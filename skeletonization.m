##close all
clear all

# séquence P1, P2, P3, P4, P5, P6, P7, P8, P9, P2
function seq = sequencePixel(img, i, j)
    seq = [img(i,j) img(i-1,j) img(i-1,j+1) img(i,j+1) img(i+1,j+1) img(i+1,j) img(i+1,j-1) img(i,j-1) img(i-1,j-1) img(i-1,j)];
end

function voisins = voisinsPixel(img, i, j)
# Extraire 9 pixels autour du pixel indexé par (i,j)
  voisins = img(i-1:i+1, j-1:j+1); 
end

function A = transition(seq)
  # calculer le nb de transitions 0-1 dans la séquence
   A = 0;
   for x = 2 : size(seq,2)-1
      if (seq(x)==0 && seq(x+1)==1)
          A=A+1;
      endif
   endfor
end

##IMG_ORG = imread('ED_data/101_1.tif');
IMG_ORG = imread('ED_data/Empreinte1.bmp');

# Afficher l'image originale
subplot(1, 2, 1);
imshow(IMG_ORG);

# Calcul du seuil pour transformer l'image gris en image binaire
seuil = graythresh(IMG_ORG)
# Binarisation
IMG_BIN = not(im2bw(IMG_ORG, seuil));
##IMG_BIN = im2bw(IMG_ORG, 0.6);

# Afficher l'image binaire
subplot(1, 2, 2);
imshow(IMG_BIN);

[rows, columns] = size(IMG_ORG);

# Image de sortie squeletisée
IMG_THIN = IMG_BIN;
# Image intermédiaire
IMG_DEL = ones(rows, columns);

changing = 1;
iteration = 0;
while changing
  changing = 0;
  iteration = iteration + 1
  for i=2:rows-1
        for j = 2:columns-1
          # 9 voisins de P1
          voisins = voisinsPixel(IMG_THIN, i, j);
          
          # P2 P3 P4 P5 P6 P7 P8 P9 P2
          seq = sequencePixel(IMG_THIN, i, j);
          
          #Calculer B(P1)
          B1 = sum(seq(2:end-1));
          
          #Calculer A(P1)
          A1 = transition(seq);
          
          # Conditions
          C3 = seq(2) * seq(4) * seq(6); # Condition 3
          C4 = seq(4) * seq(6) * seq(8); # Condition 4
          
            #################
          
          # Calculer A(P2)
          A2=0;
          if(i!=2 && j!=1 && i!=rows && j!=columns) 
            seq2 = sequencePixel(IMG_THIN, i-1, j);
            A2 = transition(seq2);
          endif
          #################
             
          # Calculer A(P4)
          A4=0;
          if(i!=1 && j!=1 && i!=rows && j!=columns-1) 
            seq4 = sequencePixel(IMG_THIN, i, j+1);
            A4 = transition(seq4);
          endif
          #################
          
          if( B1>=2 && B1<=6 && A1==1 && (C3==0 || A2!=1) && (C4==0 || A4!=1))
##          if(IMG_THIN(i,j)==1 && B1>=2 && B1<=6 && A1==1 && C3==0 && C4==0)
            IMG_DEL(i,j)=0;
            changing = 1;
          endif
        endfor
  endfor
  IMG_THIN = IMG_THIN.*IMG_DEL;  % supression des pixels marqués après le premier parcours
  # 2ème parcours
  for i=2:rows-1
        for j = 2:columns-1
          # 9 voisins de P1
          voisins = voisinsPixel(IMG_THIN, i, j);
          
          # P2 P3 P4 P5 P6 P7 P8 P9 P2
          seq = sequencePixel(IMG_THIN, i, j);
          
          #Calculer B(P1)
          B1 = sum(seq(2:end-1));
          
          #Calculer A(P1)
          A1 = transition(seq);
          
          # Conditions
          C3 = seq(2) * seq(4) * seq(6); # Condition 3
          C4 = seq(4) * seq(6) * seq(8); # Condition 4
          
          #################
          
          # Calculer A(P2)
          A2=0;
          if(i!=2 && j!=1 && i!=rows && j!=columns) 
            seq2 = sequencePixel(IMG_THIN, i-1, j);
            A2 = transition(seq2);
          endif
          #################
             
          # Calculer A(P4)
          A4=0;
          if(i!=1 && j!=1 && i!=rows && j!=columns-1) 
            seq4 = sequencePixel(IMG_THIN, i, j+1);
            A4 = transition(seq4);
          endif
          #################
          
          if( B1>=2 && B1<=6 && A1==1 && (C3==0 || A2!=1) && (C4==0 || A4!=1))
##          if(IMG_THIN(i,j)==1 &&  B1>=2 && B1<=6 && A1==1 && C3==0 && C4==0)
            IMG_DEL(i,j)=0;
            changing = 1;
          endif
        endfor
  endfor
  IMG_THIN = IMG_THIN.*IMG_DEL;  % supression des pixels marqués après le deuxième parcours
  figure
  imshow(IMG_THIN)
endwhile

subplot(1, 3, 3);
imshow(IMG_THIN);

##          #################
##          
##          # Calculer A(P2)
##          voisins2 = voisinsPixel(A, i-1, j);
##          seq2 = sequencePixel(voisins2);
##          A2 = transition(seq2);
##          #################
##             
##          # Calculer A(P4)
##          voisins4 = voisinsPixel(A, i, j+1);
##          seq4 = sequencePixel(voisins4);
##          A4 = transition(seq4);
##          #################
