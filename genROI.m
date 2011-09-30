function genROI(coords,radius,templateImage)
% generate fsl commands to create ROI images
%%
if ~exist('coords','var')
    coords = [ 14  10  62; -6  16  46 ];
end
if ~exist('radius','var')
    radius = 12;
end
if ~exist('templateImage','var')
    templateImage = '$FSLDIR/data/standard/MNI152_T1_2mm';
end

%%
numCoords = size(coords,1);

for idx = 1:numCoords
    x = coords(idx,1);
    y = coords(idx,2);
    z = coords(idx,3);
    outName = strrep(num2str(coords(idx,:)),'  ','.');
    
    pointCmd = sprintf('fslmaths %s -mul 0 -add 1 -roi %d 1 %d 1 %d 1 0 1 point',...
        templateImage,x,y,z);
    sphereCmd = sprintf('fslmaths point -kernel sphere %d -dilF  sphere.%s',...
        radius,outName);
    fprintf('%s\n%s\n',pointCmd,sphereCmd);
end

