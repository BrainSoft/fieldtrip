function test_bug2025

% WALLTIME 00:03:01

% TEST test_bug2025
% TEST ft_plot_vol ft_compute_leadfield

vol = [];
assert(ft_voltype(vol, 'infinite'))

vol.type = 'infinite';

% there is nothing to plot, but nevertheless it should not result in an error
ft_plot_vol(vol);

