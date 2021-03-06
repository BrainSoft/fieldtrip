function test_ft_senstype

% WALLTIME 00:03:04

% TEST test_ft_senstype
% TEST ft_senstype

% ft_senstype can work on different input data structures. Here, use the
% preprocessed data on /home/common/matlab/fieldtrip/test/raw/

cnt = 0;

if isunix
  maindir = '/home/common/matlab/fieldtrip/data/test/latest/raw/';
elseif ispc
  maindir = 'H:/common/matlab/fieldtrip/data/test/latest/raw/';
end
  
subdir = 'eeg';
d = dir(fullfile(maindir, subdir, '*.mat'));
for k = 1:numel(d)
  cnt = cnt+1;
  load(fullfile(maindir, subdir, d(k).name));
  fname{cnt} = d(k).name;
  type{cnt}  = ft_senstype(data);
end

subdir = 'meg';
d = dir(fullfile(maindir, subdir, '*.mat'));
for k = 1:numel(d)
  cnt = cnt+1;
  load(fullfile(maindir, subdir, d(k).name));
  fname{cnt} = d(k).name;
  type{cnt}  = ft_senstype(data);
end

subdir = 'lfp';
d = dir(fullfile(maindir, subdir, '*.mat'));
for k = 1:numel(d)
  cnt = cnt+1;
  load(fullfile(maindir, subdir, d(k).name));
  fname{cnt} = d(k).name;
  type{cnt}  = ft_senstype(data);
end

%if any(strmatch('unknown', type))
%  error('ft_senstype returns ''unknown'' sensor type for some test files on /home/common');
%end
