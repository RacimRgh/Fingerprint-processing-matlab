%Program for Fingerprint Minutiae Extraction
%
%Author : Racim RIGHI
%
%Program Description
%This program extracts the ridges and bifurcation from a fingerprint image

%Read Input Image
classdef minutiae
  methods(Static)
    function IMG_MINUTIAE = calcul(IMG_THIN)
    ##  IMG_THIN = IMG_THIN
    ##  binary_image=imread('ED_data/Empreinte1.bmp');

      # Binarisation
    ##  seuil = graythresh(binary_image)
    ##  binary_image = not(im2bw(binary_image, seuil));
      ##binary_image = binary_image(120:400,20:250);
    ##  figure;imshow(binary_image);title('Input image');

      %Thinning
    ##  IMG_THIN=~bwmorph(binary_image,'thin',Inf);
    ##  figure;imshow(IMG_THIN);title('Thinned Image');

      %Minutiae extraction
      s=size(IMG_THIN);
      N=3;%window size
      n=(N-1)/2;
      r=s(1)+2*n;
      c=s(2)+2*n;
      double temp(r,c);   
      temp=zeros(r,c);bifurcation=zeros(r,c);ridge=zeros(r,c);
      temp((n+1):(end-n),(n+1):(end-n))=IMG_THIN(:,:);
      IMG_MINUTIAE=zeros(r,c,3);%For Display
      IMG_MINUTIAE(:,:,1) = temp .* 255;
      IMG_MINUTIAE(:,:,2) = temp .* 255;
      IMG_MINUTIAE(:,:,3) = temp .* 255;
      for x=(n+1+10):(s(1)+n-10)
          for y=(n+1+10):(s(2)+n-10)
              e=1;
              for k=x-n:x+n
                  f=1;
                  for l=y-n:y+n
                      mat(e,f)=temp(k,l);
                      f=f+1;
                  endfor
                  e=e+1;
              endfor
               if(mat(2,2)==0)
                  ridge(x,y)=sum(sum(~mat));
                  bifurcation(x,y)=sum(sum(~mat));
               endif
          endfor
      endfor
      % RIDGE END FINDING
      [ridge_x ridge_y]=find(ridge==2);
      len=length(ridge_x);
      %For Display
      for i=1:len
          IMG_MINUTIAE((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)-3),2:3)=0;
          IMG_MINUTIAE((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)+3),2:3)=0;
          IMG_MINUTIAE((ridge_x(i)-3),(ridge_y(i)-3):(ridge_y(i)+3),2:3)=0;
          IMG_MINUTIAE((ridge_x(i)+3),(ridge_y(i)-3):(ridge_y(i)+3),2:3)=0;
          
          IMG_MINUTIAE((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)-3),1)=255;
          IMG_MINUTIAE((ridge_x(i)-3):(ridge_x(i)+3),(ridge_y(i)+3),1)=255;
          IMG_MINUTIAE((ridge_x(i)-3),(ridge_y(i)-3):(ridge_y(i)+3),1)=255;
          IMG_MINUTIAE((ridge_x(i)+3),(ridge_y(i)-3):(ridge_y(i)+3),1)=255;
      endfor
      %BIFURCATION FINDING
      [bifurcation_x bifurcation_y]=find(bifurcation==4);
      len=length(bifurcation_x);
      %For Display
      for i=1:len
          IMG_MINUTIAE((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)-3),1:2)=0;
          IMG_MINUTIAE((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)+3),1:2)=0;
          IMG_MINUTIAE((bifurcation_x(i)-3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),1:2)=0;
          IMG_MINUTIAE((bifurcation_x(i)+3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),1:2)=0;
          
          IMG_MINUTIAE((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)-3),3)=255;
          IMG_MINUTIAE((bifurcation_x(i)-3):(bifurcation_x(i)+3),(bifurcation_y(i)+3),3)=255;
          IMG_MINUTIAE((bifurcation_x(i)-3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),3)=255;
          IMG_MINUTIAE((bifurcation_x(i)+3),(bifurcation_y(i)-3):(bifurcation_y(i)+3),3)=255;
      endfor
    end
  end
end