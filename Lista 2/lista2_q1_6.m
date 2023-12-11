%%  --------------------------------------------------
%   Código fonte para a questão 1.6 da lista 2 de PDI
%   com o professor Edson Mintsu.
%           -- Thiago Tomás de Paula, 25/11/2023
%   --------------------------------------------------
clc; close all; clear all;

% -- O texto nos fluxogramas dos pdfs apontados no README e repetido aqui.

% (a) Explique em detalhes o algoritmo JPEG. 
%     Inclua um diagrama de blocos na sua explicacao.

    % A compressao JPEG e descrita a seguir. Para descompactar, basta
    % realizar a operacao inversa de cada etapa, indo da ultima a primeira.

    %{
    1. Divisão em blocos: 
       A imagem é dividida em blocos de pixels, geralmente de 8x8 pixels cada.
    2. Transformação de cores: 
       A imagem é convertida do espaço de cores RGB para o espaço de cores YCbCr.
    3. Transformada de DCT (Discrete Cosine Transform): 
       Cada bloco 8x8 de pixels é submetido à transformada de DCT, que converte 
       a informação espacial em coeficientes de frequência.
       Os coeficientes sao distribuidos num zigue-zague, de forma que pacotes 
       com mais energia ficam proximos a quina superior esquerda.
    4. Quantização:
       Os coeficientes de frequência resultantes da DCT são quantizados 
       dividindo-os por uma tabela de quantização. 
       Essa tabela é ajustada para controlar a perda de informação, 
       permitindo uma compressão maior (e maior perda de qualidade) 
       ou uma menor compressão (com menos perda de qualidade).
    5. Codificação Huffman: 
       Os coeficientes quantizados são submetidos à codificação Huffman, 
       associando coeficientes menos frequentes a códigos mais longos, 
       e coeficientes mais frequentes a códigos mais curtos.
    6. Compressão de dados: 
       Os códigos Huffman gerados são então combinados e comprimidos, 
       resultando na imagem JPEG compactada.
    %}


% (b) Explique em detalhes o algoritmo MPEG.
%     Inclua um diagrama de blocos na sua explicacao.

    %{
    Enquanto o JPEG e um algoritmo de compressao para imagens,
    o MPEG comprime videos.
    O MPEG possui varias versoes mas em geral sao comuns três grandes partes:
    compressão espacial, compressão temporal e codificação de vídeo.

    1. Compressão Espacial:
    a. Divisão em quadros:
    - O vídeo é dividido em uma sequência de quadros individuais. 
    Existem 3 tipos de quadros:
     - Quadros I (Intra): São quadros-chave que são completamente 
                          codificados sem referência a outros quadros. 
     - Quadros P (Predictive): Dependem de quadros anteriores (geralmente 
                               quadros I ou P) para reconstruir as 
                               informações da imagem.
     - Quadros B (Bidirecional): Dependem tanto de quadros anteriores 
                                 quanto posteriores para serem 
                                 reconstruídos.

    b. Transformação de DCT (Discrete Cosine Transform):
    - Similar à compressão JPEG, os quadros são submetidos à DCT.

    c. Quantização:
    - Os coeficientes resultantes da DCT são quantizados. 
      Essa etapa também é semelhante à quantização usada no algoritmo JPEG.

    d. Codificação de Entropia:
    - Os coeficientes quantizados são codificados usando técnicas de 
      codificação de entropia, como codificação de Huffman ou codificação 
      aritmética, para reduzir ainda mais o tamanho dos dados.

    2. Compressão Temporal:
    a. Detecção e Compensação de Movimento:
    - Os quadros P e B são codificados por meio de vetores de movimento, 
      que indicam a direção e magnitude do movimento entre quadros. 
      Isso permite armazenar apenas as diferenças entre os quadros em vez 
      de informações completas, economizando espaço.

    3. Codificação de Vídeo:
    a. Hierarquia de GOP (Group of Pictures):
    - Os quadros são organizados em uma hierarquia de GOPs, onde cada GOP 
      contém uma sequência de quadros, incluindo quadros I, P e B. 
      Isso ajuda na decodificação correta dos quadros.

    b. Entrelaçamento e Desentrelaçamento (dependendo do padrão MPEG):
    - Alguns padrões MPEG, como MPEG-2, suportam entrelaçamento para vídeos 
      intercalados (como vídeos de transmissão de TV), enquanto outros, 
      como MPEG-4, se concentram em vídeos progressivos (não entrelaçados).

    c. Multiplexação e Formato de Arquivo:
    - Os dados comprimidos de vídeo, juntamente com dados de áudio e outros 
      metadados, são multiplexados em um formato de arquivo específico
      (como MP4).
    %}


