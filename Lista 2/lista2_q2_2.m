%%  --------------------------------------------------
%   Código fonte para a questão 2.2 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;


% Baixe as imagens fig lista3 1.bmp e fig lista3 2.bmp,
% use-as como referencias para os itens que se seguem.

%% (a)
% Implemente um algoritmo de equalizacao utilizando uma abordagem global, 
% ou seja, uma abordagem baseada no histograma da imagem completa. 
% Calcular os histogramas das imagens originais. 
% Aplicar o metodo de equalizacao global para as duas imagens. 
% Apresentar as imagens originais e as suas versoes equalizadas,
% juntamente com os histogramas correspondentes.


%% Imagem 1    
clc; close all; clear all;

    % original
    f1 = imread('Lista2_imagens/fig_lista3_1.bmp');
    figure, imhist(f1);

    % equalizacao global 
    global1 = equalize_global(f1);
    figure, imhist(global1);
    
    % equalizacao local 5x5 
    local1_5x5 = equalize_local(f1,  5);
    figure, imhist(local1_5x5);
    
    % equalizacao local 7x7 
    local1_7x7 = equalize_local(f1,  7);
    figure, imhist(local1_7x7);
    
    figure, montage(cat(3, f1, global1, local1_5x5, local1_7x7), 'Size', [2 2]);
    exportgraphics(gca, 'Lista2_resultados/q2.2_f1_equalizacoes.png', 'Resolution', 300);

    
%% Imagem 2 
clc; close all; clear all;

    % original
    f2 = imread('Lista2_imagens/fig_lista3_2.bmp');
    figure, imhist(f2);

    % equalizacao global 
    global2 = equalize_global(f2);
    figure, imhist(global2);
    
    % equalizacao local 5x5 
    local2_5x5 = equalize_local(f2,  5);
    figure, imhist(local2_5x5);
    
    % equalizacao local 7x7 
    local2_7x7 = equalize_local(f2,  7);
    figure, imhist(local2_7x7);
    
    figure, montage(cat(3, f2, global2, local2_5x5, local2_7x7), 'Size', [2 2]);
    exportgraphics(gca, 'Lista2_resultados/q2.2_f2_equalizacoes.png', 'Resolution', 300);

    
%% (b) 
% Implemente um algoritmo de equalizacao usando uma abordagem local, 
% ou seja, em vez de usar o histograma da imagem completa, aplique o 
% metodo de equalizacao em pequenas sub-areas (sub-imagens) da imagem. 
% Aplique o metodo de equalizacao local para as duas imagens, 
% considerando areas de tamanhos 5x5 e 7x7.
% Visualize as imagens originais e suas versoes equalizadas, 
% juntamente com os histogramas correspondentes.
% Compare os resultados com os obtidos em (a).

% Funcao de equalizacao usado em ambos os itens (mesmo algoritmo do livro)
% https://en.wikipedia.org/wiki/Histogram_equalization
function out = equalize_global(im)
    % im: matriz 2D de uint8
    
    % Captacao das dimensoes relevantes
    [height, width] = size(im); 
    num_pixels = height * width;
    
    % Inicializacao do histograma
    hist = zeros(256, 1); 
    
    % Preenchimento do histograma
    % Note que 0<=im(i)<=255 e por isso e necessario fazer im(i)+1
    for i=1:num_pixels
        hist(im(i)+1) = hist(im(i)+1) + 1; 
    end
    
    % Funcao cumulativa a partir do histograma
    cdf = cumsum(hist);
    
    % Funcao cumulativa equalizada 
    equalized_cdf = round(255 * (cdf - min(cdf))/(num_pixels - min(cdf)));
    
    % Imagem equalizada de acordo com a cdf equalizada
    out = im;
    out(1:end, 1:end) = equalized_cdf(out(1:end, 1:end) +1);

end

function out = equalize_local(im, area_len)
    % im: matriz 2D de uint8
    % kernel_len: uint impar do kado da area local a ser equalizada
    
    % Captacao de dimensoes
    [height, width] = size(im);
    
    % Padding da imagem original
    if rem(height, area_len) == 0
        pad_h = 0;
    else
        pad_h = area_len - rem(height, area_len);
    end
    
    if rem(width, area_len) == 0
        pad_w = 0;
    else
        pad_w = area_len - rem(width, area_len);
    end
   
    padded_height = height + pad_h;
    padded_width = width + pad_w;
    
    padded_im = zeros(padded_height, padded_width);
    padded_im(1 : end-pad_h, 1 : end-pad_w) = im;
    
    for i = 1 : area_len : padded_height - area_len +1
        for j = 1 : area_len : padded_width - area_len +1 
            area = padded_im(i:(i-1)+area_len, j:(j-1)+area_len);
            padded_im(i:(i-1)+area_len, j:(j-1)+area_len) = equalize_global(area);
        end
    end
    
    unpadded_im = padded_im(1 : end-pad_h, 1 : end-pad_w);
    out = uint8(unpadded_im);
end
