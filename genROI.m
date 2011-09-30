function genROI(coords,radius)
% generate fsl commands to create ROI images
% Usage: genROI(coords,radius,templateImage)
% coords is list of coordinates with x, y, z in each row.
% radius is the radius in mm.
%% defaults
if ~exist('coords','var')
    coords = [ 14  10  62; -6  16  46 ];
end
if ~exist('radius','var')
    radius = 12;
end
if ~exist('templateImage','var')
    templateImage = '$FSLDIR/data/standard/MNI152_T1_2mm';
    
end

%% make command strings
numCoords = size(coords,1);
for idx = 1:numCoords
    voxelspace = mni2voxel(coords(idx,:));
    x = voxelspace(1);
    y = voxelspace(2);
    z = voxelspace(3);
    outName = ['sphere.' strrep(num2str(coords(idx,:)),'  ','_')];
    
    pointCmd = sprintf('fslmaths %s -mul 0 -add 1 -roi %d 1 %d 1 %d 1 0 1 point',...
        templateImage,x,y,z);
    sphereCmd = sprintf('fslmaths point -kernel sphere %d -dilF %s',...
        radius,outName);
    fprintf('%s\n%s\n',pointCmd,sphereCmd);
end

