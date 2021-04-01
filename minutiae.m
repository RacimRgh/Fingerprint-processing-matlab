classdef minutiae
  methods(Static)
    # Fonction de calcul des minuties
    # Paramètre: image squeletisé
    # Retourne: l'image avec les minuties
    # la matrice des bifurcations
    # la matrice des terminaisons
    function [IMG_MINUTIAE, bif, ter] = calcul2(IMG_THIN)
      [nl, nc] = size(IMG_THIN); # taille de l'image
      imshow(IMG_THIN);title('Minutiae'); # image originale squeletisé sur laquelle on affichera les minuties
      # Matrices qui vont contenir les bifurcations et terminaisons, mises à 0
      bif = zeros(nl, nc);
      ter = zeros(nl, nc);
      # Parcours de l'image
      for i=2:nl-2
        for j = 2:nc-2
          if IMG_THIN(i,j)==1
                P = squeletisation.sequencePixel(IMG_THIN,i,j); # récupérer la séquence de pixels autour 
                # Calculer le coefficient CN
                CN=0;
                for x=2:9
                  CN = CN +(abs(P(x+1) - P(x))); # formule de detection des minuties (connectivité)
                endfor
                CN = 0.5*CN;
                CN = round(CN);
                
                # Traitement en fonction du type de minutie
                switch(CN) 
                  case {1} # Points terminal
                    ter(i,j)=1; # Matrice de points terminaux
                    hold on;
                    plot(i,j,'or'); # On dessine un cercle rouge
                    break;
                 case {3} % Points de Biffurcation
                    bif(i,j) = 1; # Matrice de points de bifurcation
                    hold on;
                    plot(i,j,'xb'); # on dessine une croix bleu
                    break;
                endswitch
            endif
        endfor
      endfor
      IMG_MINUTIAE = IMG_THIN;
    endfunction
    
    # Calcul de la distance de Hausdorff
    # Fonction qui calcule la distance de hausdorff entre 2 matrices envoyés en paramètre
    # Les paramètres seront dans notre cas les matrices de bifurcations et de terminaisons de 2 empreintes digitales différentes
    # return: distance de Hausdorff
    function result = compare_minuties(tab1, tab2)
      # Récupérer les indices des minuties
      [r1 c1] = find(tab1==1); # r1 == lignes, c1 == colonnes tab1(r1,c1)==minutie
      
      [r2 c2] = find(tab2==1);
      
      n = size(r1, 1); # nombre de minuties à comparer (taille du tableau)
      m = size(r2, 1);
      ls=[];
      shortest=10000; # variable temporaire pour la comparaison (MAX)
      for x=1:n
        for y=1:m
          # Calcul de la distance euclidienne entre 2 pixels (minuties)
          # P1(x1, y1) et P2(x2,y2)
          Y = abs(c2(y)-c1(x))*abs(c2(y)-c1(x)); # (y2 - y1) * (y2 - y1)
          X = abs(r2(y)-r1(x))*abs(r2(y)-r1(x)); # (x2 - x1) * (x2 - x1)
          d = round(sqrt(X+Y));
          
          if shortest > d
            shortest = d;
            ls(end+1) = shortest; # Ajouter la nouvelle valeur au tableau
          endif
          
        endfor
      endfor
      result = max(ls);
    endfunction
    
    # Calcul de la distance de Hausdorff
    function dh = hausdorff(tab1, tab2)
      tab1 = tab1(tab1>=0);
      tab2 = tab2(tab2>=0);
      d1 = minutiae.compute_dist(tab1, tab2);
      d2 = minutiae.compute_dist(tab2, tab1);
      dh = max(d1, d2);
    endfunction
    
    # Calcul de la distance
    function dist = compute_dist(A, B)
      m = size(A);
      n = size(B);
      d_vec = [];
      D = [];
      % dim= size(A, 2); 
      for j = 1:m(2)
          for k= 1: n(2)
          D(k) = abs((A(j)-B(k)));
          endfor
          d_vec(j) = min(D); 
      endfor
      dist = min(d_vec);
    endfunction
  endmethods
endclassdef
