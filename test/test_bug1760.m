function test_bug1760

% WALLTIME 00:03:07

% TEST test_bug1760
% TEST ft_multiplotER ft_multiplotTFR

cd(dccnfilename('/home/common/matlab/fieldtrip/data/test'))
load bug1760.mat

figure
ft_multiplotER(cfg, freq);

