classdef squeletisation
  methods(Static)
    # calculer la séquence P1, P2, P3, P4, P5, P6, P7, P8, P9, P2
    function seq = sequencePixel(img, i, j)
        seq = [img(i,j) img(i-1,j) img(i-1,j+1) img(i,j+1) img(i+1,j+1) img(i+1,j) img(i+1,j-1) img(i,j-1) img(i-1,j-1) img(i-1,j)];
    end
    
    # calculer le nb de transitions 0-1 dans la séquence précédente
    function A = transition(seq)
       A = 0;
       for x = 2 : size(seq,2)-1
          if (seq(x)==0 && seq(x+1)==1)
              A=A+1;
          endif
       endfor
    end
    
    # Fonction de squeletisation
    # Paramètres: IMG_ORG: l'image originale - IMG_BIN: l'image binaire
    # Retourne: l'image squeletisé
    function IMG_THIN = skl(IMG_ORG, IMG_BIN)
      [rows, columns] = size(IMG_BIN);
      # Image de sortie squeletisée
      IMG_THIN = IMG_BIN;
      # Image intermédiaire
      # Elle va servir à supprimer les pixels "inutiles"
      IMG_DEL = ones(rows, columns);

      changing = 1;
      iteration = 0;
      ##while changing
      for x=1:4
        changing = 0;
        iteration = iteration + 1
        for i=2:rows-1
              for j = 2:columns-1
                # P2 P3 P4 P5 P6 P7 P8 P9 P2
                seq = squeletisation.sequencePixel(IMG_THIN, i, j);
                
                #Calculer B(P1)
                # Le nombre de pixels à 1 dans la séquence
                B1 = sum(seq(2:end-1));
                
                #Calculer A(P1)
                # Le nombre de transitions de 0 à 1 dans la séquence du pixel P1
                A1 = squeletisation.transition(seq);
                
                # Conditions
                C3 = seq(2) * seq(4) * seq(6); # Condition 3
                C4 = seq(4) * seq(6) * seq(8); # Condition 4
                
                #################
                # Calculer A(P2)
                # Le nombre de transitions de 0 à 1 dans la séquence du pixel P2
                A2=0;
                # Si P2 est dans un des bords de l'image, on calcule pas A(p2) (pas de voisins)
                if(i!=2 && j!=1 && i!=rows && j!=columns) 
                  seq2 = squeletisation.sequencePixel(IMG_THIN, i-1, j);
                  A2 = squeletisation.transition(seq2);
                endif
                #################
                #################
                # Calculer A(P4)
                # Le nombre de transitions de 0 à 1 dans la séquence du pixel P4
                A4=0;
                # Si P4 est dans un des bords de l'image, on calcule pas A(P4) (pas de voisins)
                if(i!=1 && j!=1 && i!=rows && j!=columns-1) 
                  seq4 = squeletisation.sequencePixel(IMG_THIN, i, j+1);
                  A4 = squeletisation.transition(seq4);
                endif
                #################
                #################
                # Vérifier les conditions de Hilditch
                if( B1>=2 && B1<=6 && A1==1 && (C3==0 || A2!=1) && (C4==0 || A4!=1))
      ##          if(IMG_THIN(i,j)==1 && B1>=2 && B1<=6 && A1==1 && C3==0 && C4==0)
                  IMG_DEL(i,j)=0;
                  changing = 1;
                endif
                #################
              endfor
        endfor
        IMG_THIN = IMG_THIN.*IMG_DEL;  % supression des pixels marqués après le premier parcours
##        # 2ème parcours
##        for i=2:rows-1
##              for j = 2:columns-1
##                # P2 P3 P4 P5 P6 P7 P8 P9 P2
##                seq = squeletisation.sequencePixel(IMG_THIN, i, j);
##                
##                #Calculer B(P1)
##                B1 = sum(seq(2:end-1));
##                
##                #Calculer A(P1)
##                A1 = squeletisation.transition(seq);
##                
##                # Conditions
##                C3 = seq(2) * seq(4) * seq(6); # Condition 3
##                C4 = seq(4) * seq(6) * seq(8); # Condition 4
##                
##                #################
##                
##                # Calculer A(P2)
##                A2=0;
##                if(i!=2 && j!=1 && i!=rows && j!=columns) 
##                  seq2 = squeletisation.sequencePixel(IMG_THIN, i-1, j);
##                  A2 = squeletisation.transition(seq2);
##                endif
##                #################
##                   
##                # Calculer A(P4)
##                A4=0;
##                if(i!=1 && j!=1 && i!=rows && j!=columns-1) 
##                  seq4 = squeletisation.sequencePixel(IMG_THIN, i, j+1);
##                  A4 = squeletisation.transition(seq4);
##                endif
##                #################
##                
##                if( B1>=2 && B1<=6 && A1==1 && (C3==0 || A2!=1) && (C4==0 || A4!=1))
##      ##          if(IMG_THIN(i,j)==1 &&  B1>=2 && B1<=6 && A1==1 && C3==0 && C4==0)
##                  IMG_DEL(i,j)=0;
##                endif
##              endfor
##        endfor
##        # On supprime les pixels
##        IMG_THIN = IMG_THIN.*IMG_DEL;  % supression des pixels marqués après le deuxième parcours  
      endfor
    end
  end
end