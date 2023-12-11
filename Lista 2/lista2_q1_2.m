%%  --------------------------------------------------
%   Código fonte para a questão 1.2 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

% Considere as imagens da Figura 1. A imagem da direita foi obtida por: 
% (1) filtrando a imagem da esquerda com um filtro gaussiano passa-baixa e 
% (2) filtrando o resultado com um filtro gaussiano passa-alta. 
% As imagens tem 420 × 344 pixels e ambos
% os filtros tem uma frequencia de corte D0 = 25.
% 
% (a) Explique por que razao a parte central da imagem a direita (o anel) 
% tem um aspecto solido e brilhante, tendo em conta que as principais 
% caracteristicas da imagem filtrada sao as linhas na borda exterior dos 
% objetos (por exemplo, dedos, ossos, etc.) com uma area mais escura entre 
% essas linhas. Por outras palavras, nao seria de se esperar que o filtro 
% passa-alta produzisse uma ´area constante no interior do anel, dado que 
% o passa-alta elimina o termo DC?
%     Para o passa-baixas, frequencias alem da de corte sao atenuadas, e
%     frequencias abaixo, preservadas. Para o passa-altas, ocorre o
%     contrario, frequencias acima se preservam e abaixo se atenuam.
%     Para um elemento de cor solida mais clara rodeada de cor solida mais
%     escura, como e o caso do anel e dos dedos, o passa-baixas forma uma 
%     borda cinza borrada por volta do elemento. Da zona escura ate o ponto
%     mais claro, essa borda cria um  gradiente de cinza que sera 
%     preservado pelo passa-altas desde que esteja acima da frequencia de 
%     corte.
%     O que acontece com o anel que nao acontece com os ossos e que, sendo
%     o anel mais fino/esbelto, grande parte desse elemento apos o
%     passa-baixas esta no gradiente comentado, que para D0=25 foi
%     preservado pelo passa-altas.
%     Nos ossos, o 'miolo' atingido apos se passar da borda cinza do
%     passa-baixas e uma cor solida, e portanto sera atenuada pelo
%     passa-alta, escurecendo essa parte.
%     Com isso dito, e possivel notar um ligeiro acinzentamento no interior
%     do anel, indicando atenuacao do passa-altas.  

1.2(b)
% Se invertessemos a ordem de aplicacao dos filtros, 
% o resultado seria o mesmo?
%     Nao. Ao aplicar o passa-altas primeiro, nao existiria a borda cinza
%     comentada no ultimo item, e portanto poucos pontos no interior dos
%     ossos/anel estariam dentro de um gradiente preservado pelo
%     passa-altas. Em outras palavras, o anel e dedos ficariam escuros 
%     imediatamente.
%     Em seguida, filtrar esse resultado pelo passa-baixas apenas borraria
%     a imagem, dificultando a visualizacao. O codigo abaixo valida as
%     respostas dadas neste item e no anterior. 

    
%% Validacao
clc; close all; clear all;

% Imagem RGB similar ao raio X da Figura 1 
xray = imread('Lista2_resultados/q1.2_ring_xray.jpg');
xray = rgb2ycbcr(xray);
xray = xray(:,:,1);

% Aumentando a frequencia de corte para ver se o anel fica escuro
% Para D0=15, o anel fica branco no interior.
for D0 = 10:5:20
    
    % passa-baixas seguido de passa-altas
    low = gaussian_filter(xray, D0, "low");    
    lowhigh = gaussian_filter(low, D0, "high");
    figure, imshow(lowhigh, []);
    title(sprintf("Passa-baixas depois altas, D0=%d", D0));
    
    % passa-altas seguido de passa-baixas
    high = gaussian_filter(xray, D0, "high");    
    highlow = gaussian_filter(high, D0, "low");
    figure, imshow(highlow, []);
    title(sprintf("Passa-altas depois baixas, D0=%d", D0));
    
end


%% Feito baseado no codigo em
% https://www.mathworks.com/matlabcentral/fileexchange/39701-gaussian-high-pass-filter
function out = gaussian_filter(im, D0, type)

    [height, width] = size(im);
    filter = zeros(height, width);

    p = height/2;
    q = width/2;

    for i=1:height
        for j=1:width
            D2 = (i-p)^2 + (j-q)^2; % distancia ao quadrado
            if type == "high"
                filter(i,j) = 1 - exp(-D2/(2*(D0^2)));
            elseif type == "low"
                filter(i,j) = exp(-D2/(2*(D0^2)));
            end
        end
    end

    f_shift = fftshift(fft2(im));
    filtered_ft = f_shift .* filter;
    out_ft = ifftshift(filtered_ft);
    
    out = uint8(abs(ifft2(out_ft)));

end

