% function test_bug1806

% TEST test_bug1806
% TEST ft_componentanalysis ft_megplanar ft_megrealign

ctf151 = load('/home/common/matlab/fieldtrip/data/test/latest/sens/ctf151.mat');
ctf275 = load('/home/common/matlab/fieldtrip/data/test/latest/sens/ctf275.mat');


global ft_default
ft_default = [];

cfg = [];
cfg.dataset = '/home/common/matlab/fieldtrip/data/Subject01.ds';
cfg.trl = [1 900 0];
data = ft_preprocessing(cfg);
% the following applies since 30 October 2012
% the type will be added by ft_datatype_sens if not present
assert(strcmp(data.grad.type, 'ctf151'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% megplanar and combineplanar

cfg = [];
cfg.method = 'distance';
neighbours = ft_prepare_neighbours(cfg, data);

cfg = [];
cfg.neighbours = neighbours;
data_p  = ft_megplanar(cfg,data);
if isfield(data_p.grad, 'type')
  % it should not be ctf151 any more
  assert(strcmp(data_p.grad.type, 'ctf151_planar'));
else
  warning('gradiometer type is missing')
  assert(ft_senstype(data_p.grad, 'ctf151_planar'));
end

cfg = [];
data_pc = ft_combineplanar(cfg,data_p);
if isfield(data_pc.grad, 'type')
  % it should again be ctf151
  assert(strcmp(data_pc.grad.type, 'ctf151'));
else
  warning('gradiometer type is missing');
  assert(ft_senstype(data_pc.grad, 'ctf151'));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% megrealign with another template

vol.type = 'singlesphere';
vol.unit = 'cm';
vol.r = 12;
vol.o = [0 0 4];

cfg = [];
cfg.vol = vol;
cfg.inwardshift = 0;
cfg.template = {ctf275.grad};
data_r = ft_megrealign(cfg, data);
assert(strcmp(data_r.grad.type, 'ctf275'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% componentanalysis and rejectcomponent

cfg = [];
cfg.method = 'pca';
data_c = ft_componentanalysis(cfg, data);
if isfield(data_c.grad, 'type')
  % don't know what it is, but it should not be ctf151
  assert(~strcmp(data_c.grad.type, 'ctf151'));
else
  warning('gradiometer type is missing');
  assert(~ft_senstype(data_c.grad, 'ctf151'));
end

cfg = [];
cfg.component = [];
data_cb = ft_rejectcomponent(cfg, data_c);
if isfield(data_cb.grad, 'type')
  % it should again be ctf151
  assert(strcmp(data_cb.grad.type, 'ctf151'));
else
  warning('gradiometer type is missing');
  assert(ft_senstype(data_cb.grad, 'ctf151'));
end