function [] = main()
% normalizes the bvals and splits the bvecs

% load config.json
config = loadjson('config.json');

% Parameters used for normalization
params.shells       = config.shell;
bvals = dlmread(config.bvals);
bvecs = dlmread(config.bvecs);
dwi = niftiRead(config.dwi);

for i = 1:length(params.shells)
    index = (bvals == params.shells(i));
    index0 = (bvals == 0);
    all_index = or(index, index0);
    assertEqual(sum(all_index), sum(index0) + sum(index));
    
    %write files
    dlmwrite(sprintf('dwi.bvals', params.shells(i)), bvals(all_index));
    dlmwrite(sprintf('dwi.bvecs', params.shells(i)), bvecs(:,all_index));
    dwi_oneshell = dwi;
    dwi_oneshell.fname = sprintf('dwi.nii.gz', params.shells(i));
    dwi_oneshell.data = dwi.data(:,:,:,all_index);
    dwi_oneshell.dim(4) = size(dwi_oneshell.data,4);
    niftiWrite(dwi_oneshell);
end


