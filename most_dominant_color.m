
function most_dominant_color

if isempty(ls('MDC.mat'))   

    files{1} = ls('*.tiff');
    files{2} = ls('*.tif');
    files{3} = ls('*.bmp');
    files{4} = ls('*.jpg');
    files{5} = ls('*.jpeg');
    files{6} = ls('*.png');
    
    init_k = 1;
    init_j = 1;
    saida = [];
    
else
    load MDC
    init_k = run_k; 
    init_j = run_j; 
end

for k = init_k:6
    for j = init_j:size(files{k},1)
        
        run_k = k;
        run_j = j;
        save MDC files saida run_k run_j
        save MDC_RED files saida run_k run_j %redundant
        
        saida{k}(j,:) = dominant(files{k}(j,:));
    end
end

run_k = k + 1;
run_j = j + 1;
save MDC files saida run_k run_j

pause(0.5);
eval(sprintf('!del MDC_RED.mat'));

end


function saida = dominant(figs)

n_bits = 6; %consider the 6 most significant bits
resolut = 2^n_bits;

I1 = imread(figs);
I1 = imresize(I1,0.25); %reduce the image dimension in order to reduce time processing

if size(I1,3) == 3
    IU1 = I1(:,:,1); %R
    IU1 = IU1(:);
    
    IU2 = I1(:,:,2); %G
    IU2 = IU2(:);
    
    IU3 = I1(:,:,3); %B
    IU3 = IU3(:);
        
elseif size(I1,3) == 1 %gray scale image
    IU1 = I1(:,:,1);
    IU1 = IU1(:);
    IU2 = IU1;
    IU3 = IU1;
end

Im_1 = IU1;
Im_2 = IU2;
Im_3 = IU3;

%reduce image resolution in order to reduce time processing and obtain
%better result
Im_1 = Im_1(:)*((resolut-1)/255); 
Im_2 = Im_2(:)*((resolut-1)/255); 
Im_3 = Im_3(:)*((resolut-1)/255); 

III = double([Im_1 Im_2 Im_3]);

Im = double(Im_1) + resolut*double(Im_2) + (resolut*resolut)*double(Im_3);

%compute the image histogram
A = zeros(1,resolut*resolut*resolut);
for i = 1:length(Im)
    A(Im(i)+1) = A(Im(i)+1) + 1;
end

%find the bins different from zero (colors)
Index = find(A ~= 0);
Index = Index - 1;

for i = 1:length(Index)
    Cores(i,:) = color_retrieval(Index(i),resolut);
    Freq(i) = A(Index(i)+1);
end

%compute Euclidian distance of each color to all colors
B = inf*ones(1,size(Cores,1));
for i = 1:size(Cores,1)
    B(i) = sum(sqrt(sum((ones(size(Cores,1),1)*Cores(i,:) - Cores).^2,2)).*Freq');
end

[tmp,IDX] = sort(B);
IDX = IDX(1); %ID of the most predominant color

%identify the colors nearest to the most predominant color
C = inf*ones(1,size(Cores,1));
for i = 1:size(Cores,1)
    if i ~= IDX
        C(i) = sqrt(sum((Cores(IDX,:) - Cores(i,:)).^2));
    end
end

ID = find(C <= 3); %find the colors with distance lesser or equal 3
ID = [ID IDX];

Im_media = Freq(ID)*Cores(ID,:)/sum(Freq(ID)); %compute weighted mean of the colors

R = Im_media(1)*255/(resolut-1);
G = Im_media(2)*255/(resolut-1);
B = Im_media(3)*255/(resolut-1);

saida(1) = uint8(R);
saida(2) = uint8(G);
saida(3) = uint8(B);


%show the color
%IM_1 = R*ones(100,100); 
%IM_2 = G*ones(100,100); 
%IM_3 = B*ones(100,100);
%IM(:,:,1) = uint8(IM_1);
%IM(:,:,2) = uint8(IM_2);
%IM(:,:,3) = uint8(IM_3);
%imshow(IM);


%saida = sprintf('%s %s %s',dec2hex(floor(R*255/(resolut-1))),dec2hex(floor(G*255/(resolut-1))),dec2hex(floor(B*255/(resolut-1))));

end

function I = color_retrieval(Index,resolut)

B = floor(Index/(resolut*resolut));
G = floor((Index - B*resolut*resolut)/resolut);
R = Index - B*resolut*resolut - G*resolut;
I = [R G B];
end

