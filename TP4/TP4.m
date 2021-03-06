% TP 4 Imagerie sous pixellique
% Sofiane Horache

%% Exercice 11 Décomposition (p+s)
clear all;
clf();

%visualisation de p et s

u = double(imread('images/lena.pgm'));
[p,s]= perdecomp(u);
figure(1);
imshow([u,p,s],[]);
% on remarque la similarité de p et s. on rajoute [] pour que la dynamique
% soit adapté automatiquement. le pixel le plus clair est 1 est le plus
% sombre est 0.

%verifions la consistance de cette decomposition
res =norm(u-p-s);
% on a res = 3.0454e-13 ce qui est négligeable
% on peut donc consiférer que c'est consistent
%les differences entre u et p sont minimes on peut remarquer des
%changements aux bords alors que pour u périodisé les limites sont claires 
%pour l'image p les frontières sont plus lisse.
figure();imshow(kron(ones(2,2),u),[ ]);
figure();imshow(kron(ones(2,2),p),[ ]);
figure();imshow(kron(ones(2,2),s),[ ]);
% on voit que les frontière pour s sont bien défini c'est s le parametre
% smooth qui définit les frontières de u
%Visualisation de la TF de u p et s

fft_u = fftshift(fft2(u));
fft_p = fftshift(fft2(p));
fft_s = fftshift(fft2(s));
figure(); imshow([log(1+fft_u), log(1+fft_p), log(1+fft_s)],[])
figure(); imshow([angle(fft_u), angle(fft_p), angle(fft_s)],[])
% on voit que la croix qui se voyait sur le module et la phase TF de u ne se voit pas sur la
% phase et module de la TF de p. la TF de s est un ensemble de croix sur certaine ligne la TF(s)
% est constante TF de s est décroissante.

v = fsym2(u);
figure(); imshow(v,[]);
fft_v = fft2(v);
[M,N] = size(v);
[xx,yy]= meshgrid(0:M-1,0:N-1);
affine = pi/M * yy + pi/N*xx;
figure(); 
subplot(121);
imshow(log(1+fft_u),[]);
subplot(122);
imshow(log(1+fftshift(fft_v)),[]);
figure();
subplot(121);
imshow(angle(fft_u),[]);
subplot(122);
imshow(fftshift(mod(angle(fft_v)-affine+pi/2,2*pi)-pi/2),[]);
% pour v les artefacts de la périodisation disparaissent dans le module.
% Mais la symetrisation detruit des informations dans la phase