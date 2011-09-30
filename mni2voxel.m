function voxelspace = mni2voxel(inputvoxel) 
% convert mni coordinates to voxel coordinates in the fsl 2mm standard
% brain image
% inputvoxel should be [x y z ; x y z ; x y z] MNI_152 coordinates
% original author dvsmith
% from http://www.biac.duke.edu/forums/topic.asp?TOPIC_ID=1172

%my assumptions:
%voxel size == 2mm iso
%datasize=(91,109,91)
%mniorigin=[45 63 36] %identified as MNI coordinate [0 0 0] in fslview for fsl standard brain

mniorigin=[45 63 36];
yourvoxel=[-1 1 1] .* inputvoxel/2; % x and y flipped between MNI and voxel space
voxelspace = yourvoxel + mniorigin;
