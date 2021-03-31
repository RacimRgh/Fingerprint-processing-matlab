classdef minutiae
  methods(Static)
    # Extraction des minuties
##    function IMG_MINUTIAE = calcul(IMG_THIN)  
##      s=size(IMG_THIN);
##      # lignes et colonnes
##      r=s(1)+ 2;
##      c=s(2)+ 2;
##      double temp(r,c);   
##      temp=zeros(r,c);
##      # Matrices des bifurcations et des cr�test
##      bifurcation=zeros(r,c);
##      ridge=zeros(r,c);
##      # Matrice temporaire pour faire les calculs
##      temp(2:(end-1), 2:(end-1))=IMG_THIN(:,:);
##      # pour l'affichage, utiliser une image couleur pour ajoute les cercles rouges/bleus 
##      IMG_MINUTIAE = zeros(r,c,3);
##      IMG_MINUTIAE(:,:,1) = temp .* 255;
##      IMG_MINUTIAE(:,:,2) = temp .* 255;
##      IMG_MINUTIAE(:,:,3) = temp .* 255;
##      # Parcour de l'image
##      for x=2:s(1)-2
##          for y=2:s(2)-2
##              if temp(x,y) ==1
##                # Parcourir les voisins du pixel
##                e=1;
##                for k=x-1:x+1
##                    f=1;
##                    for l=y-1:y+1
##                        mat(e,f)=temp(k,l);
##                        f=f+1;
##                    endfor
##                    e=e+1;
##                endfor
##                # Methode de calcul de la somme des voisins de la matrice transpos�
##                # Si r�sultat ==2 alors cr�te
##                # Si r�sultat ==4 alors bifurcation
##                if(mat(2,2)==0)
##                   ridge(x,y)=sum(sum(~mat));
##                   bifurcation(x,y)=sum(sum(~mat));
##                endif
##              endif
##              
##          endfor
##      endfor
##      
##      # Trouver les cr�tes et les colorer avec un rectangle rouge
##      [ridge_x ridge_y]=find(ridge==2);
##      len=length(ridge_x);
##      bif = zeros(r, c)
##      rid = zeros(r, c)
##      for i=1:len
##          rid(ridge_x(i), rid(i)) = 1;
####        IMG_MINUTIAE = viscircles ([ridge_x(i) ridge_y(i)], [2 2])
##          IMG_MINUTIAE((ridge_x(i)-1):(ridge_x(i)+1),(ridge_y(i)-1),2:3)=0;
##          IMG_MINUTIAE((ridge_x(i)-1):(ridge_x(i)+1),(ridge_y(i)+1),2:3)=0;
##          IMG_MINUTIAE((ridge_x(i)-1),(ridge_y(i)-1):(ridge_y(i)+1),2:3)=0;
##          IMG_MINUTIAE((ridge_x(i)+1),(ridge_y(i)-1):(ridge_y(i)+1),2:3)=0;
##          
##          IMG_MINUTIAE((ridge_x(i)-1):(ridge_x(i)+1),(ridge_y(i)-1),1)=255;
##          IMG_MINUTIAE((ridge_x(i)-1):(ridge_x(i)+1),(ridge_y(i)+1),1)=255;
##          IMG_MINUTIAE((ridge_x(i)-1),(ridge_y(i)-1):(ridge_y(i)+1),1)=255;
##          IMG_MINUTIAE((ridge_x(i)+1),(ridge_y(i)-1):(ridge_y(i)+1),1)=255;
##      endfor
##      # Trouver les bifurcations et les colorer avec un rectangle bleu
##      [bifurcation_x bifurcation_y]=find(bifurcation==4);
##      len=length(bifurcation_x);
##      len
##      for i=1:len
##          bif(bifurcation_x(i), bifurcation_y(i)) = 1;
####        IMG_MINUTIAE = viscircles ([bifurcation_x(i) bifurcation_y(i)], [10 20])
##          IMG_MINUTIAE((bifurcation_x(i)-1):(bifurcation_x(i)+1),(bifurcation_y(i)-1),1:2)=0;
##          IMG_MINUTIAE((bifurcation_x(i)-1):(bifurcation_x(i)+1),(bifurcation_y(i)+1),1:2)=0;
##          IMG_MINUTIAE((bifurcation_x(i)-1),(bifurcation_y(i)-1):(bifurcation_y(i)+1),1:2)=0;
##          IMG_MINUTIAE((bifurcation_x(i)+1),(bifurcation_y(i)-1):(bifurcation_y(i)+1),1:2)=0;
##          
##          IMG_MINUTIAE((bifurcation_x(i)-1):(bifurcation_x(i)+1),(bifurcation_y(i)-1),3)=255;
##          IMG_MINUTIAE((bifurcation_x(i)-1):(bifurcation_x(i)+1),(bifurcation_y(i)+1),3)=255;
##          IMG_MINUTIAE((bifurcation_x(i)-1),(bifurcation_y(i)-1):(bifurcation_y(i)+1),3)=255;
##          IMG_MINUTIAE((bifurcation_x(i)+1),(bifurcation_y(i)-1):(bifurcation_y(i)+1),3)=255;
##      endfor
##    endfunction
  
    function [IMG_MINUTIAE, bif, ter] = calcul2(IMG_THIN)
##      s=size(IMG_THIN)
      [nl, nc] = size(IMG_THIN);
      imshow(IMG_THIN);title('Minutiae');
      bif = zeros(nl, nc);
      ter = zeros(nl, nc);
      for i=2:nl-2
        for j = 2:nc-2
          if IMG_THIN(i,j)==1
##              if(i!=1 && j!=1 && i<r-2 && j<c-2) 
##                P = squeletisation.sequencePixel(IMG_THIN,i,j);
                P=[IMG_THIN(i-1,j) IMG_THIN(i-1,j+1) IMG_THIN(i,j+1) IMG_THIN(i+1,j+1) IMG_THIN(i+1,j) IMG_THIN(i+1,j-1) IMG_THIN(i,j-1) IMG_THIN(i-1,j-1) IMG_THIN(i-1,j)];
                CN=0;
                for x=1:8
                  CN = CN +(abs(P(x+1) - P(x)));
                endfor
                CN = 0.5*CN;
                CN = round(CN);
                switch(CN) %traitement en fonction du type de minutie
                  case {1} % Points terminaux
                    ter(i,j)=1;
                    hold on;
                    plot(i,j,'or');
                    break;
                 case {3} % Points de Biffurcation
                    bif(i,j) = 1;
                    hold on;
                    plot(i,j,'xb');
                    break;
##                  case {4} % Points de Croisement
##                    hold on;
##                    plot(x,y,'*y');
##                    break;
                endswitch  % end de la boucle switch
            endif
        endfor
      endfor
      IMG_MINUTIAE = IMG_THIN;
    endfunction
    # Calcul de la distance de Hausdorff
    function result = compare_minuties(tab1, tab2)
      [nl,nc] = size(tab1);
      h = 0;
      ls=[];
      shortest=1000;
      tab = tab1.*tab2;
      for x=1:nl
        for y=1:nc
          if tab1(x,y)==1
            for i=1:nl
              for j=1:nc
                if tab2(i,j)==1
                  Y = abs(y-j)*abs(y-j);
                  X = abs(x-i)*abs(x-i);
                  d = round(sqrt(X+Y)); 
                  if shortest > d
                    shortest = d;
                    ls = [ls, shortest];
                  endif
                endif
              endfor
            endfor
          endif
        endfor
      endfor
      result = min(ls);
    endfunction
    # Calcul de la distance de Hausdorff
    function dh = hausdorff(tab1, tab2)
      tab1 = tab1(tab1>=0);
      tab2 = tab2(tab2>=0);
      dh = max(minutiae.compute_dist(tab1, tab2), minutiae.compute_dist(tab2, tab1));
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
