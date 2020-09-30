function [ Valor,Juici,Juici2 ] = Cuentabilletes( I,umb,discrimina )
%Esta función tiene como entrada la imagen de un billete y devuelve la 
%denominación del mismo y su autenticidad en base al hilo de seguridad

imshow(I);
title('Imagen billete en pantalla blanca')
SE1=strel('disk',1);
I2=im2bw(I,umb);
figure();
imshow(I2);
title('Imagen binarizada con el umb elegido')
I22=im2bw(I);
figure();
I22=imclose(I22,SE1);
imshow(I22);
title('Imagen en negro de la imagen')

[findblackx,findblacky]=find(I22==0);

maxbx=max(findblackx(:))-min(findblackx(:))
maxby=max(findblacky(:))-min(findblacky(:));
M=zeros(maxbx,maxby);
M=I2(min(findblackx(:)):max(findblackx(:)),min(findblacky(:)):max(findblacky(:)));%Imagen recortada falso 
Mc=1-M;
b=numel(M(1,:));
sumas1=zeros(size(b));
rate=maxby/maxbx;

for j=1:b
   sumas1(j)=sum(Mc(:,j));
end

Maximo=max(sumas1(:));
Juici=numel(find(sumas1(:)==Maximo));
Juici2=numel(find(sumas1(:)==Maximo-1));
if (Juici+Juici2>10)
    error('No es un billete')
end

[r,t]=max(sumas1(:));
figure();
imshow(Mc);

tamanoco1=size(Mc);
colum1=tamanoco1(1);

if (rate>2.2 && rate<2.3)
    Z=500;
elseif(rate>2.1 && rate<2.2)
    Z=200;
else 
    fprintf('No es un billete de las denominaciones aceptadas')
end

if(r>discrimina*colum1)
    fprintf(['Es un billete real de ', num2str(Z),' pesos \n'] )
    Valor=Z;
else
    fprintf(['Es un billete falso de ',num2str(Z),' pesos \n'])
    Valor=0;
end
end

