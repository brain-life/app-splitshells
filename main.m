function [] = main()
% normalizes the bvals and splits the bvecs

if ~isdeployed
    disp('loading paths')
    addpath(genpath('/N/u/brlife/git/vistasoft'))
    addpath(genpath('/N/u/brlife/git/jsonlab'))
end

config = loadjson('config.json');

% Parameters used for normalization
params.shells       = config.shell;
bvals = dlmread(config.bvals);
bvecs = dlmread(config.bvecs);
dwi = niftiRead(config.dwi);

% Round the numbers to the closest thousand 
[bvals_unique, ~, bvals_uindex] = unique(bvals);
bvals_unique(bvals_unique <= config.b0_max) = 0;
bvals_unique = round(bvals_unique./config.bvals_round)*config.bvals_round;
bvals_round = bvals_unique( bvals_uindex )

for i = 1:length(params.shells)
    index = (bvals_round == params.shells(i));
    index0 = (bvals_round == 0);
    all_index = or(index, index0);
    assertEqual(sum(all_index), sum(index0) + sum(index));
    
    %write files
    dlmwrite(sprintf('dwi.bvals', params.shells(i)), bvals_round(all_index), 'delimiter',' ');
    dlmwrite(sprintf('dwi.bvecs', params.shells(i)), bvecs(:,all_index));
    dwi_oneshell = dwi;
    dwi_oneshell.fname = sprintf('dwi.nii.gz', params.shells(i));
    dwi_oneshell.data = dwi.data(:,:,:,all_index);
    dwi_oneshell.dim(4) = size(dwi_oneshell.data,4);
    niftiWrite(dwi_oneshell);
end


