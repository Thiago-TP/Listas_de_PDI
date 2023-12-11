%%  --------------------------------------------------
%   Código fonte para a questão 1.1 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

% Uma forma de obter a derivada discreta 2-D (aproximacao) e calcular as
% diferencas f(x + 1, y) − f(x, y) e f(x, y + 1) − f(x, y).
% (a) Encontre o filtro equivalente no dom´ınio da frequencia (H(u, v)).
% (b) Mostre que esse filtro e um passa-alta


%% Validacao
clc; close all; clear all;

fig = imread('Lista2_resultados/q1.2_ring_xray.jpg');
fig = rgb2ycbcr(fig);
fig = fig(:,:,1);

% kernel para [f(x+1,y)-f(x,y)] + [f(x,y+1)-f(x,y)] 
der_kernel = [0  0  0
              0 -2  1
              0  1  0];

im_space = imfilter(fig, der_kernel);

im_freq = uint8(real(ifft2(ft_filter(fig))));

figure, montage(cat(3, fig, im_freq));
exportgraphics(gcf, "Lista2_resultados/q1.1_result.png", 'Resolution', 300);


function out = ft_filter(im)

    im_ft = fft2(double(im));
    out = im_ft;
    
    [height, width, ~] = size(im);
    for u=1:height
        for v=1:width
            H = exp(1i*2*pi*u/height) + exp(1i*2*pi*v/width) - 2;
            out(u, v) = im_ft(u, v) * H;
        end
    end
    
end


