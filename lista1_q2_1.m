%%  --------------------------------------------------
%   Código fonte para a questão 2.1 da lista 1 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 23/10/2023
%   --------------------------------------------------
clc; close all; clear all;


%% 2.1(c) 
clc; close all; clear all;

    memorial = hdrread('source_files/hw1_memorial.hdr'); % matriz 3d de single
    memorial_grayscale = rgb2gray(memorial);

    atrium = hdrread('source_files/hw1_atrium.hdr');     % matriz 3d de single
    atrium_grayscale = rgb2gray(atrium);

    figure, imshow(atrium, []);             % para comparação
    exportgraphics(gca,'results/atrium.png', 'Resolution', 300)
    figure, imshow(atrium_grayscale, []);    
    exportgraphics(gca,'results/atrium_grayscale.png', 'Resolution', 300)

    figure, imshow(memorial, []);           % para comparação
    exportgraphics(gca,'results/memorial.png', 'Resolution', 300)
    figure, imshow(memorial_grayscale, []);    
    exportgraphics(gca,'results/memorial_grayscale.png', 'Resolution', 300)


%% 2.1(d) - https://www.mathworks.com/help/images/gamma-correction.html
%         - https://www.mathworks.com/help/matlab/ref/double.cat.html
clc; close all; clear all;

% Parte 1: grayscale
    memorial = hdrread('source_files/hw1_memorial.hdr');
    memorial_grayscale = rgb2gray(memorial);
    memorial_gs0_5 = imadjust(memorial_grayscale, [], [], 0.5); % gamma=0.5 (clareia)
    memorial_gs1_0 = imadjust(memorial_grayscale, [], [], 1.0); % gamma=1.0 (original)
    memorial_gs1_5 = imadjust(memorial_grayscale, [], [], 1.5); % gamma=1.5 (escurece)
    figure, montage([memorial_gs0_5, memorial_gs1_0, memorial_gs1_5]);
    exportgraphics(gca,'results/memorial_grayscale_corrections.png', 'Resolution', 300)

    atrium = hdrread('source_files/hw1_atrium.hdr');
    atrium_grayscale = rgb2gray(atrium);
    atrium_gs0_5 = imadjust(atrium_grayscale, [], [], 0.5); % gamma=0.5 (clareia)
    atrium_gs1_0 = imadjust(atrium_grayscale, [], [], 1.0); % gamma=1.0 (original)
    atrium_gs1_5 = imadjust(atrium_grayscale, [], [], 1.5); % gamma=1.5 (escurece)
    figure, montage([atrium_gs0_5, atrium_gs1_0, atrium_gs1_5]);
    exportgraphics(gca,'results/atrium_grayscale_corrections.png', 'Resolution', 300)

% Clarear a imagem melhora a visualização de detalhes nas imagens cinzas.
% Parte 2: cores
% ---------- [trecho do memorial] ----------
    memorial_red = memorial(:,:,1);
    memorial_r0_5 = imadjust(memorial_red, [], [], 0.5); % gamma=0.5 (clareia)
    memorial_r1_0 = imadjust(memorial_red, [], [], 1.0); % gamma=1.0 (original)
    memorial_r1_5 = imadjust(memorial_red, [], [], 1.5); % gamma=1.5 (escurece)

    memorial_green = memorial(:,:,2);
    memorial_g0_5 = imadjust(memorial_green, [], [], 0.5); % gamma=0.5 (clareia)
    memorial_g1_0 = imadjust(memorial_green, [], [], 1.0); % gamma=1.0 (original)
    memorial_g1_5 = imadjust(memorial_green, [], [], 1.5); % gamma=1.5 (escurece)

    memorial_blue = memorial(:,:,3);
    memorial_b0_5 = imadjust(memorial_blue, [], [], 0.5); % gamma=0.5 (clareia)
    memorial_b1_0 = imadjust(memorial_blue, [], [], 1.0); % gamma=1.0 (original)
    memorial_b1_5 = imadjust(memorial_blue, [], [], 1.5); % gamma=1.5 (escurece)
       
    memorial_darkred_corrected = cat(3, memorial_r1_5, memorial_g1_0, memorial_b1_0);
    memorial_lightred_corrected = cat(3, memorial_r0_5, memorial_g1_0, memorial_b1_0);
    memorial_aux = cat(4, memorial, memorial_darkred_corrected, memorial_lightred_corrected);
    figure, montage(memorial_aux, 'Size', [1 3]);
    exportgraphics(gca,'results/memorial_red_correction.png', 'Resolution', 300)
    
    memorial_darkgreen_corrected = cat(3, memorial_r1_0, memorial_g1_5, memorial_b1_0);
    memorial_lightgreen_corrected = cat(3, memorial_r1_0, memorial_g0_5, memorial_b1_0);
    memorial_aux = cat(4, memorial, memorial_darkgreen_corrected, memorial_lightgreen_corrected);
    figure, montage(memorial_aux, 'Size', [1 3]);
    exportgraphics(gca,'results/memorial_green_correction.png', 'Resolution', 300)
    
    memorial_darkblue_corrected = cat(3, memorial_r1_0, memorial_g1_0, memorial_b1_5);
    memorial_lightblue_corrected = cat(3, memorial_r1_0, memorial_g1_0, memorial_b0_5);
    memorial_aux = cat(4, memorial, memorial_darkblue_corrected, memorial_lightblue_corrected);
    figure, montage(memorial_aux, 'Size', [1 3]);
    exportgraphics(gca,'results/memorial_blue_correction.png', 'Resolution', 300)

    memorial_corrected = cat(3, memorial_r0_5, memorial_g0_5, memorial_b0_5);
    memorial_aux = cat(4, memorial, memorial_corrected);
    figure, montage(memorial_aux, 'Size', [1 2]);
    exportgraphics(gca,'results/memorial_best_corrections.png', 'Resolution', 300)


%% 2.1(e)
clc; close all; clear all;

    memorial = hdrread('source_files/hw1_memorial.hdr');
    gamma = 0.5; % gamma não precisa ser variado aqui
    for n=[0.25, 0.5, 0.75, 1.0]
        for sigma=[1.0, 1.5, 2, 2.5, 3]
            figure
            LDR_memorial = HDRtoLDR(memorial, n, sigma, gamma);
            imshow(LDR_memorial, []);
            title(sprintf('n=%.2f, sigma=%.2f, gamma=%.2f', n, sigma, gamma));
        end
    end

    
%% funções
% função que converte imagem em HDR em LDR
function LDRimage = HDRtoLDR(HDRimage, n, sigma, gamma)
    HDR_R = HDRimage(:,:,1);
    HDR_G = HDRimage(:,:,2);
    HDR_B = HDRimage(:,:,3);
    % make conversion on each color plane
    LDR_R = convert_x(HDR_R, n, sigma, gamma);
    LDR_G = convert_x(HDR_G, n, sigma, gamma);
    LDR_B = convert_x(HDR_B, n, sigma, gamma);
    % return finished conversion
    LDRimage = cat(3, LDR_R, LDR_G, LDR_B);
end

% função que converte um plano de imagem HDR para LDR 
function y = convert_x(matrix_2d, n, sigma, gamma)
    [height, width] = size(matrix_2d);
    y = zeros(height, width);
    for i=1:height
       for j=1:width
           x = matrix_2d(i, j);
           y(i, j) = (x^n / (x^n + sigma^n))^(1/gamma);
       end
    end
end
