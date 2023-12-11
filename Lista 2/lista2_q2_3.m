%%  --------------------------------------------------
%   Código fonte para a questão 2.3 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

% Baixe o arquivo "imagensruidosas". 
% Este arquivo comprimido contem um conjunto de imagens com ruıdo.     
% Implemente 2 filtros (a sua escolha) para remover o ruıdo.
% Utilize esses filtros para remover o ruıdo em cada uma das imagens. 
% Discuta os resultados obtidos. Quando possivel, 
% descreva o tipo de ruido presente na imagem.
    

%% Lena 
clc; close all; clear all;

% 'lena.png' nao tem ruido
lena = imread('Lista2_imagens/imagensruidosas/lena.png'); 
    
    % filtrada por media
    lena_average = filtering(lena, 'average');    
    
    % filtrada por mediana
    lena_median = filtering(lena, 'median');
    
    figure, montage([lena, lena_average, lena_median]);
    exportgraphics(gca, 'Lista2_resultados/q2.3_lena_filtragens.png', 'Resolution', 300);

% Analise: nao faz sentido analisar atenuacao de ruido numa entrada sem
% ruido.

    
%% Lena sigma25  
clc; close all; clear all;

% 'lena_sigma25.png' tem ruido gaussiano, fica aparente no histograma
lena_sigma25 = imread('Lista2_imagens/imagensruidosas/lena_sigma25.png');

    % original
    figure, imhist(lena_sigma25); % forma do histograma em relacao ao golden mostra que o ruido e gaussiano
    
    % filtrada por media
    lena_sigma25_average = filtering(lena_sigma25, "average");  
    
    % filtrada por mediana
    lena_sigma25_median = filtering(lena_sigma25, "median");
    
    figure, montage([lena_sigma25, lena_sigma25_average, lena_sigma25_median]);
    exportgraphics(gca, 'Lista2_resultados/q2.3_lena_sigma25_filtragens.png', 'Resolution', 300);
    
% Analise: ambos os filtros atenuam o ruido de forma a obter resultados
% similares, mas os artefatos deixados pelo da mediana sao, subjetivamente,
% mais desagradáveis ao olho humano.

    
%% Lena sp
clc; close all; clear all;

% 'lena-sp.png' tem ruido salt & pepper (obvio da figura)
lena_salt_pepper = imread('Lista2_imagens/imagensruidosas/lena-sp.png');
    
    % filtrada por media
    lena_salt_pepper_average = filtering(lena_salt_pepper, "average");
    
    % filtrada por mediana
    lena_salt_pepper_median = filtering(lena_salt_pepper, "median");
    
    figure, montage([lena_salt_pepper, lena_salt_pepper_average, lena_salt_pepper_median]);
    exportgraphics(gca, 'Lista2_resultados/q2.3_lena_salt_pepper_filtragens.png', 'Resolution', 300);
    
% Analise: o ruido salt & pepper e eficazmente removido pelo filtro da
% mediana, embora com artefatos inevitaveis, intrinsecos dessa filtragem.
% Isso era o esperado, uma vez que os pontos brancos e pretos do ruido
% raramente sao a mediana dos pontos considerados, e mesmo quando estao na
% mediana, isso significa simplesmente que a maior parte da area
% considerada e ou preta ou branca, e a interferencia do ruido e minima.

    
%% JFK
clc; close all; clear all;

% 'JFKreg.jpg' tem ruido periodico, indicado pela FT de seu brilho
JFK = imread('Lista2_imagens/imagensruidosas/JFKreg.jpg');

    % original convertido para grayscale
    JFK_yuv = rgb2ycbcr(JFK);
    JFK_Y = JFK_yuv(:,:,1);
    
    % FT do grayscale (ruido periodico evidente)
    JFK_ft = fftshift(fft2(double(JFK_Y)));
    figure, imshow(log(abs(JFK_ft)), []); 
    exportgraphics(gca, 'Lista2_resultados/q2.3_JFK_ft.png', 'Resolution', 300);

    % grayscale filtrado por media
    JFK_average = filtering(JFK_Y, "average");
    JFK_average_ft = fftshift(fft2(double(JFK_average)));
    figure, imshow(log(abs(JFK_average_ft)), []);
    exportgraphics(gca, 'Lista2_resultados/q2.3_JFK_average_ft.png', 'Resolution', 300); 
    
    % grayscale filtrado por mediana
    JFK_median = filtering(JFK_Y, "median");
    JFK_median_ft = fftshift(fft2(double(JFK_median)));
    figure, imshow(log(abs(JFK_median_ft)), []); 
    exportgraphics(gca, 'Lista2_resultados/q2.3_JFK_median_ft.png', 'Resolution', 300);
    
    figure, montage([JFK_Y, JFK_average, JFK_median]);
    exportgraphics(gca, 'Lista2_resultados/q2.3_JFK_filtragens.png', 'Resolution', 300);

% Analise: embora nenhum filtro tenha sido capaz de atenuar o ruido de
% maneira eficaz, o filtro da media restringe os padroes ruidosos as baixas
% frequencias, como mostra a FT da imagem apos a filtragem. O filtro da
% mediana consegue eliminar uma pequena porcao dos padroes periodicos 
% (segmentos verticais), mas a maior parte desse padrao fica intocado 
% (segmentos diagonais). Alem disso, os artefatos gerados na filtragem de
% mediana sao, subjetivamente, mais desagradaveis ao olho humano que os
% artefatos da filtragem por media.

    
%% Filtros escolhidos: mediana e media 5x5
function out = filtering(im, type)

    % Definindo tamanho do kernel
    kernel_len = 5; 
    
    % Percorrendo a imagem de entrada 
    [im_height, im_width, ~] = size(im);    
    
    pad = (kernel_len - 1)/2; 
    padded_height = im_height + 2*pad;
    padded_width = im_width + 2*pad;
    
    padded_im = zeros(padded_height, padded_width);
    padded_im(pad+1:end-pad, pad+1:end-pad) = im;
    
    out = zeros(padded_height, padded_width);    
    
    for i = 1 : (padded_height - kernel_len) +1
        for j = 1 : (padded_width - kernel_len) +1
            im_sample = padded_im(i:i+kernel_len-1, j:j+kernel_len-1);
            if type == "average"
                out(i +pad, j +pad) = mean(im_sample, 'all');
            elseif type == "median"
                out(i +pad, j +pad) = median(im_sample, 'all');
            end
        end
    end
    
    out = uint8(out(pad+1:end-pad, pad+1:end-pad));
    
end
