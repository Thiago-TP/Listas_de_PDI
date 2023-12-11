%%  --------------------------------------------------
%   Código fonte para a questão 1.4 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

Mostre que a subtracao do Laplaciano de uma imagem e proporcional ao
'mascaramento unsharp'. 
Utilize a definicao de Laplaciano dada pela equacao (3.6-3).

% imagem original:
% f = f(x, y)

% imagem apos filtragem por passa-baixas:
% f_low = f_low(x, y) = f_Sxy * kernel_low 

% mascara unsharp:
% g = g(x,y) = f - f_low

% resultado do unsharp:
% fhat = f + kg = f + k(f - f_low)

% unsharp em um kernel:
% M = [0 0 0
%      0 1 0
%      0 0 0] 
%     + 
%     [0 0 0
%      0 k 0
%      0 0 0]
%     -k low_pass kernel
% = 
% (k+1)*I - k*low_pass kernel

% k=1, low_pass kernel = ones(3)/9 =>
% M =   0 0 0
%       0 1+k 0
%       0 0 0
%       -
%       k k k
%       k k k
%       k k k  / 9
%     = -k/9 -k/9 -k/9
%       -k/9 1 + 8k/9 -k/9          
%       -k/9 -k/9 -k/9
%     =  I - (k/9)laplacian

% aqui, laplacian representa
% laplacian = [1 1  1
%              1 -8 1
%              1 1  1].

% Em geral, um unsharp masking com filtro de media aritmetica de tamanho
% nxn e realced k e equivalente ao laplaciano de ordem n com realce
% c=k/n^2.


%% Validacao
clc; clear all, close all;

    % figura de teste (mesma da questao 1.2)
    fig = imread('Lista2_resultados/q1.2_ring_xray.jpg');
    fig = rgb2ycbcr(fig);
    fig = fig(:,:,1);
    
    % https://www.mathworks.com/help/images/ref/imsharpen.html#btppxju-3_1
    k = 2; % realce do unsharp
    dim = 3; % dimensoes dos filtros
    I = zeros(dim); 
    I((dim+1)/2, (dim+1)/2) = 1;
    
    fig_sharpen = imfilter(fig, I + k*(I - ones(dim)/dim^2));
    
    c = -k/dim^2; % realce do filtro laplaciano
    lap = ones(dim);    
    lap((dim+1)/2, (dim+1)/2) = 1 - dim^2;    
    lap_kernel = I + c*lap;
    
    fig_laplacian = imfilter(fig, lap_kernel);
    figure, montage(cat(3, fig_sharpen, fig_laplacian));
    title("Unsharpen masking (esquerda) e Laplaciano (direita)")
    
    figure, imhist(fig_sharpen);
    title("Unsharp masking");
    
    figure, imhist(fig_laplacian);    
    title("Laplace");    
    