
clear all;
close all;

%%%%%%%%%%%%%%%% AFFICHAGE IMAGE INITIAL %%%%%%%%%%%%%%%%

% première empreinte
I1 = imread('ED_data/Empreinte1.bmp');
[NL,NC]=size(I1); %hauteur et largeur de l'image / WIDTH / HEIGHT de l'image 1

subplot(4,2,1);
imshow(I1); title('image initiale 1');

% deuxième image 
I2 = imread('ED_data/Empreinte2.bmp');
[NL2,NC2]=size(I2); %hauteur et largeur de l'image / WIDTH / HEIGHT de l'image 2

subplot(4,2,2);
imshow(I2); title('image initiale 2');

%%%%%%%%%%% HISTOGRAMME %%%%%%%%%%%%%%%%%%


%histogramme image 1
h1=zeros(1,256);
    for y=1:NL
        for x=1:NC
            h1(I1(y,x)+1)= h1(I1(y,x)+1) +1;
        end
    end
subplot(4,2,3);
plot(h1); title('Histogramme de l image 1 ');


%histogramme image 2
h2=zeros(1,256);
    for y=1:NL2
        for x=1:NC2
            h2(I2(y,x)+1)= h2(I2(y,x)+1) +1;
        end
    end
subplot(4,2,4);
plot(h2); title('Histogramme de l image 2 ');

%%%%%%%%%%%% BINARISATION PAR SEUILLAGE %%%%%%%%%%%%%%
seuil1 = 160; %empreinte 1
seuil2 = 160; %empreinte 2

%binarisation par seuillage de l'image 1
Ib1 = zeros(NL,NC);
    for y=1:NL
        for x=1:NC
            if I1(y,x)<seuil1   %si le pixel est inférieur au seuil on tranforme le pixel en blanc
                Ib1(y,x)=0; % affectation du pixel en blanc
            else
                Ib1(y,x)=1; % affectation du pixel en noir
            end %fin du si
        end %fin de boucle parcours colonne
    end %fin de boucle parcours ligne
subplot(4,2,5);
imshow(Ib1); title('Image Binarise 1');


%binarisation par seuillage de l'image 2
Ib2 = zeros(NL2,NC2);
    for y=1:NL2
        for x=1:NC2
            if I2(y,x)<seuil2   %si le pixel est inférieur au seuil on tranforme le pixel en blanc
                Ib2(y,x)=0; % affectation du pixel en blanc
            else
                Ib2(y,x)=1; % affectation du pixel en noir
            end %fin du si
        end %fin de boucle parcours colonne
    end %fin de boucle parcours ligne
subplot(4,2,6);
imshow(Ib2); title('Image Binarise 2');

%%%%%%%%%%%%%%%%%%% IMAGE BINARISE  %%%%%%%%%%%%%%%%%%%

%inversion de l'image binarisé 1
Ibn1 = ~Ib1
subplot(4,2,7);
imshow(Ibn1); title('Image Binarise Inversé 1');   

%inversion de l'image binarisé 1
Ibn2 = ~Ib2
subplot(4,2,8);
imshow(Ibn2); title('Image Binarise Inversé 2');   


%hildich
    
##for y=2:NL-1 %on n'accède pas aux bords de l'image
##  for x=2:NC-1
##    %P1=I(y,x); %p1 est le pixel au milieu
##    A=0; % A est le nombre de transition 0 à 1
##    B=0; % B est le nombre de voisins
##    tab=[Ii(y-1,x) Ii(y-1,x+1) Ii(y,x+1) Ii(y+1,x+1) Ii(y+1,x) Ii(y+1,x-1) Ii(y,x-1) Ii(y-1,x-1) Ii(y-1,x)];
##    for k=1:8
##            if((tab(k+1)-tab(k))==1)  % une transition de P1
##                A=A+1;
##            elseif (tab(k)~=0)      % un voisin
##                B=B+1;
##            end
##    end
##     
##     % test des 4 conditions 
##        c3=(tab(1)*tab(3)*tab(7));
##        c4=(tab(1)*tab(3)*tab(5));
##          if((A==1) && (B>=2 && B<=6) && (c3==0  ) && (c4==0 ))
##                    Ii(y,x)=0;
##          end   
##  end
##end

##thinning = 1;
##eraceCount = 0;
##eracePixel(NL,NC) = 1;
##while thinning == 1
##  for y=2:NL-1 %on n'accède pas aux bords de l'image
##   for x=2:NC-1
####     condition1 = 0;
####     condition2 = 0;
####     condition3 = 0;
####     condition4 = 0;
####      if(Ii(y,x)==0) % black pixel
##        B=0;
##        A=0;
##        tab=[Ii(y-1,x) Ii(y-1,x+1) Ii(y,x+1) Ii(y+1,x+1) Ii(y+1,x) Ii(y+1,x-1) Ii(y,x-1) Ii(y-1,x-1) Ii(y-1,x)];
##        
##       
##         %for condition 2
##         for k=1:8
##            if((tab(k+1)-tab(k))==1)  % une transition de P1
##                A=A+1;
##            elseif (tab(k)~=0)      % un voisin
##                B=B+1;
##            end
##          end
##          
##          
##          
##          if((tab(1)*tab(3)*tab(7))==0) %cond 3
##            condition3=1;
##          end
##          
##          if((tab(1)*tab(3)*tab(5))==0) %cond 4
##            condition4=1;
##          end
##          
##          
##          %  Calculer A(P2)
##        y2=y-1;
##        x2=x;
##        P2=[Ii(y2-1,x2) Ii(y2-1,x2+1) Ii(y2,x2+1) Ii(y2+1,x2+1) Ii(y2+1,x2) Ii(y2+1,x2-1) Ii(y2,x2-1) Ii(y2-1,x2-1) Ii(y2-1,x2)];
##        A2 =0;
##        for k=1:8 
##            if((P2(k+1)-P2(k))==1)  % une transition de P2
##                A2=A2+1;
##            end
##        end
##        
##        if (A2 ~= 1)
##            condition3 = 1;
##        end 
##        
##        %  Calculer A(P4) 
##        y4=y;
##        x4=x+1;
##        P4=[Ii(y4-1,x4) Ii(y4-1,x4+1) Ii(y4,x4+1) Ii(y4+1,x4+1) Ii(y4+1,x4) Ii(y4+1,x4-1) Ii(y4,x4-1) Ii(y4-1,x4-1) Ii(y4-1,x4)];
##        A4=0;
##        for k=1:8 
##            if((P4(k+1)-P4(k))==1)  % une transition de P4
##                A4=A4+1;
##            end
##        end
##        
##        if (A4 ~= 1)
##            condition3 = 1;
##        end 
##        
##         if ((condition1 + condition2 + condition3 + condition4 )== 4)
##                      eracePixel(y,x) = 0;
##                      eraceCount = eraceCount + 1;
##          end
##         
##         
##         
####      end 
##      
##   end
##  end
##  if eracePixel == 0;
##     thinning = 0;
##      end
##      Ii = Ii + eracePixel;
##      %clear all values in matrix eracePixel 
##      eracePixel = zeros(NL, NC);
##end

##subplot(3,4,5);
##imshow(Ii);title('Squelittisation '); 

figure(2)
%%%%%%%%%%% SQUELETISATION HILDICH %%%%%%%%%%%%

%squeletisation empreinte 1 

Is1 = bwmorph(Ibn1,'thin',Inf);
subplot(4,2,1)
imshow(Is1); title('squeletisation image 1');

%squeletisation empreinte 2 

Is2 = bwmorph(Ibn2,'thin',Inf);
subplot(4,2,2)
imshow(Is2); title('squeletisation image 2');


%%%%%%%%%%%%% AFFICHAGE MINUTIES SUR L' IMAGE %%%%%%%%%%%%


%Imin=ones(NL,NC);

##imshow(Imin);

%afichage minuties image 1

subplot(4,2,3)
imshow(Is1); title('Image avec minuties 1');

for y=2:NL-2
        for x=2:NC-2
            if Is1(y,x)==1 %detecter seulement si le pixel est blanc
                %extrait les 8 voisins de p1 ( p2 p3 p4 p5 p6 p7 p8 p9=p2 ) dans le tableau tab
                tab=[Is1(y-1,x) Is1(y-1,x+1) Is1(y,x+1) Is1(y+1,x+1) Is1(y+1,x) Is1(y+1,x-1) Is1(y,x-1) Is1(y-1,x-1) Is1(y-1,x)];
                c=0;
                
                for k=1:8 %parcours des pixel voisins de p1 dans tab
                    c=c+(abs(tab(k+1)-tab(k)));
##                    Cn= 0.5*(abs(tab(k+1)-tab(k))); %forumule du crossing number                
##                    c=Cn+c;
                end %fin de boucle du calcul crossing number 
               
                c=0.5*c;
                c=round(c); % arrondir pour que c soit un nombre entier
                switch(c) %traitement en fonction du type de minutie
                  case {1} % Points terminaux
                    hold on;
                    plot(x,y,'or');
                    break;
                  case {3} % Points de Biffurcation
                    hold on;
                    plot(x,y,'xb');
                    break;
##                  case {4} % Points de Croisement
##                    hold on;
##                    plot(x,y,'*y');
##                    break;
                end  % end de la boucle switch
               
            end % end fin du if test pixel blanc
        end %end fin de boucle sur x
end % end fin de boucle sur y



%afichage minuties image 2

subplot(4,2,4)
imshow(Is2); title('Image avec minuties 2');
for y=2:NL2-2
        for x=2:NC2-2
            if Is2(y,x)==1 %detecter seulement si le pixel est blanc
                %extrait les 8 voisins de p1 ( p2 p3 p4 p5 p6 p7 p8 p9=p2 ) dans le tableau tab
                tab=[Is2(y-1,x) Is2(y-1,x+1) Is2(y,x+1) Is2(y+1,x+1) Is2(y+1,x) Is2(y+1,x-1) Is2(y,x-1) Is2(y-1,x-1) Is2(y-1,x)];
                c=0;
                
                for k=1:8 %parcours des pixel voisins de p1 dans tab
                    c=c+(abs(tab(k+1)-tab(k)));
##                    Cn= 0.5*(abs(tab(k+1)-tab(k))); %forumule du crossing number                
##                    c=Cn+c;
                end %fin de boucle du calcul crossing number 
               
                c=0.5*c;
                c=round(c); % arrondir pour que c soit un nombre entier
                switch(c) %traitement en fonction du type de minutie
                  case {1} % Points terminaux
                    hold on;
                    plot(x,y,'or');
                    break;
                  case {3} % Points de Biffurcation
                    hold on;
                    plot(x,y,'xb');
                    break;
##                  case {4} % Points de Croisement
##                    hold on;
##                    plot(x,y,'*y');
##                    break;
                end  % end de la boucle switch
               
            end % end fin du if test pixel blanc
        end %end fin de boucle sur x
end % end fin de boucle sur y



%%%%%%%%%%%%% AFFICHAGE MINUTIES SEULS %%%%%%%%%%%%

%empreinte 1 
subplot(4,2,5)
Im1=ones(NL,NC);
imshow(Im1);title('Minuties empreinte 1');

tabTerm1=ones(NL,NC);
tabBifu1=ones(NL,NC);



for y=2:NL-2
        for x=2:NC-2
            if Is1(y,x)==1 %detecter seulement si le pixel est blanc
                %extrait les 8 voisins de p1 ( p2 p3 p4 p5 p6 p7 p8 p9=p2 ) dans le tableau tab
                tab=[Is1(y-1,x) Is1(y-1,x+1) Is1(y,x+1) Is1(y+1,x+1) Is1(y+1,x) Is1(y+1,x-1) Is1(y,x-1) Is1(y-1,x-1) Is1(y-1,x)];
                c=0;
                
                for k=1:8 %parcours des pixel voisins de p1 dans tab
                    c=c+(abs(tab(k+1)-tab(k)));
##                    Cn= 0.5*(abs(tab(k+1)-tab(k))); %forumule du crossing number                
##                    c=Cn+c;
                end %fin de boucle du calcul crossing number 
               
                c=0.5*c;
                c=round(c); % arrondir pour que c soit un nombre entier
                switch(c) %traitement en fonction du type de minutie
                  case {1} % Points terminaux
                    tabTerm1(y,x)=0;
                    hold on;
                    plot(x,y,'or');
                    break;
                 case {3} % Points de Biffurcation
                    tabBifu1(y,x);
                    hold on;
                    plot(x,y,'xb');
                    break;
##                  case {4} % Points de Croisement
##                    hold on;
##                    plot(x,y,'*y');
##                    break;
                end  % end de la boucle switch
               
            end % end fin du if test pixel blanc
        end %end fin de boucle sur x
end % end fin de boucle sur y


%empreinte 2
subplot(4,2,6)
Im2=ones(NL2,NC2);
imshow(Im2);title('Minuties empreinte 2');

tabTerm2=ones(NL2,NC2);
tabBifu2=ones(NL2,NC2);



for y=2:NL2-2
        for x=2:NC2-2
            if Is2(y,x)==1 %detecter seulement si le pixel est blanc
                %extrait les 8 voisins de p1 ( p2 p3 p4 p5 p6 p7 p8 p9=p2 ) dans le tableau tab
                tab=[Is2(y-1,x) Is2(y-1,x+1) Is2(y,x+1) Is2(y+1,x+1) Is2(y+1,x) Is2(y+1,x-1) Is2(y,x-1) Is2(y-1,x-1) Is2(y-1,x)];
                c=0;
                
                for k=1:8 %parcours des pixel voisins de p1 dans tab
                    c=c+(abs(tab(k+1)-tab(k)));
##                    Cn= 0.5*(abs(tab(k+1)-tab(k))); %forumule du crossing number                
##                    c=Cn+c;
                end %fin de boucle du calcul crossing number 
               
                c=0.5*c;
                c=round(c); % arrondir pour que c soit un nombre entier
                switch(c) %traitement en fonction du type de minutie
                  case {1} % Points terminaux
                    tabTerm2(y,x)=0;
                    hold on;
                    plot(x,y,'or');
                    break;
                 case {3} % Points de Biffurcation
                    tabBifu2(y,x);
                    hold on;
                    plot(x,y,'xb');
                    break;
##                  case {4} % Points de Croisement
##                    hold on;
##                    plot(x,y,'*y');
##                    break;
                end  % end de la boucle switch
               
            end % end fin du if test pixel blanc
        end %end fin de boucle sur x
end % end fin de boucle sur y                
        
        
%%%%%%%%%%%%%%%%%%%%%%% Identification des empreintes %%%%%%%%%%%%%%%%%%%%

% Distance de Hausdorff                      

h1 = 0 ; % distance de Hausdorff des terminaisons
shortest1=1000;    % intialisation 
% liste des min distance de chaque terminaisons
ls=[]; 


for y1=2:NL-2
    for x1=2:NC-2  
        if tabTerm1(y1,x1)==0  % une terminaison
            for y2=2:NL2-2
                for x2=2:NC2-2
                    if tabTerm2(y2,x2)==0 
                        Y = (y2-y1)*(y2-y1);
                        X = (x2-x1)*(x2-x1);
                        dEuc = round(sqrt(X+Y)); % distance euclidienne 
                        if shortest1 > dEuc
                            shortest1 = dEuc;  
                            ls = [ls, shortest1];
                        end
                    end
                end
            end
        end     
    end
end

##ls = sort(ls); 
##h1 = ls(1);
##

h2 = 0;
ls2=[];
shortest2=1000;

for y1=2:NL-2
    for x1=2:NC-2  
        if tabBifu1(y1,x1)==0  % une biffurcation
            for y2=2:NL2-2
                for x2=2:NC2-2
                    if tabBifu2(y2,x2)==0  
                        Y = (y2-y1)*(y2-y1);
                        X = (x2-x1)*(x2-x1);
                        dEuc = round(sqrt(X+Y)); 
                        if shortest2 > dEuc
                            shortest2 = dEuc;
                            ls2 = [ls2, shortest2];
                        end
                    end
                end
            end
        end             
    end
end

##ls2 = sort(ls2); 
##h2 = ls2(1);
##
##if h1==0 && h2==0    % Les deux Empreintes Digitales
##    disp('les 2 empreintes digitales sont identiques');
##else
##    disp('les 2 empreintes digitales ne sont pas identiques');
##end      
   
  
