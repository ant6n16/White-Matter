[X, meta] = nrrdread('RM Cerebro/Ej2_t2.nrrd');

% Pruebas visualizacion
figure (1)
imshow(GROUNDTRUTH(:,:,14),[]);

figure (2)
imshow(X(:,:,106),[]);

%% VALIDACION PACIENTE %%

%Paciente 1: 84 - Paciente 2: 89/92 - Paciente 3: 88 - Paciente 4: 89 - Paciente 5: - 89 

im=logical(X);
mask=zeros(size(GROUNDTRUTH,3));
FP=0;
FN=0;
TP=0;
TN=0;

for i=1:size(GROUNDTRUTH,3)
    mask = im(:,:,i+92) - GROUNDTRUTH(:,:,i);
    mask2 = im(:,:,i+92) + GROUNDTRUTH(:,:,i);
    
    FP=FP+length(find(mask==1));
    FN=FN+length(find(mask==-1));
    TP=TP+length(find(mask2==2));
    TN=TN+length(find(mask2==0));
    
end

%% VALIDACION: PARAMETROS %%

Sensitivity = TP/(TP+FN);
Specificity = TN/(TN+FP);
PPV = TP/(TP+FP);
NPV = TN/(TN+FN);

% Paciente 1: - Paciente 2: 90,130/93, - Paciente 3: 89,119 - Paciente 4:
% 90,123 - Paciente 5: 90-120

Jaccard = jaccard_coefficient(im(:,:,93:133),GROUNDTRUTH(:,:,1:41));
Dice = 2*nnz(im(:,:,93:133)&GROUNDTRUTH(:,:,1:41))/(nnz(im(:,:,93:133)) + nnz(GROUNDTRUTH(:,:,1:41)));
