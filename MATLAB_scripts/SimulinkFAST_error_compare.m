function [] = SimulinkFAST_error_compare(outb_dir)

params = {'PtfmSurge', 'PtfmSway', 'PtfmHeave', 'PtfmPitch', 'PtfmRoll', ...
    'PtfmYaw'};%, 'PtfmTVxi', 'PtfmTVyi', 'PtfmTVzi', 'PtfmRVyi', 'PtfmRVxi', 'PtfmRVzi'};

fields_read = {'PtfmSurge', 'PtfmSway', 'PtfmHeave', 'PtfmPitch', 'PtfmRoll', ...
    'PtfmYaw'};%, 'PtfmSurgeVel', 'PtfmSwayVel', 'PtfmHeaveVel', 'PtfmPitchVel', ...
%'PtfmRollVel', 'PtfmYawVel'};

outb_files = dir(outb_dir);
outb_files = {outb_files.name};

fast_file = outb_files(contains(outb_files, '_FAST'));
fast_file = join([outb_dir, '/', fast_file], '');
simulink_file = outb_files(contains(outb_files, '_hybrid'));
simulink_file = join([outb_dir, '/', simulink_file], '');
[fast_data, fast_params] = ReadFASTbinary(fast_file{1});
[simulink_data, simulink_params] = ReadFASTbinary(simulink_file{1});
nrmse_errors = zeros(length(params), 1);

for k = 1:length(params)
    fast_param_col = strcmp(params{k}, fast_params);
    simulink_param_col = strcmp(params{k}, simulink_params);
    
    point_errors = ((fast_data(:, fast_param_col) - simulink_data(:, simulink_param_col))).^2;
    data_range = max(fast_data(:, fast_param_col)) - min(fast_data(:, fast_param_col));
    param_nrmse = sqrt(sum(point_errors) / length(point_errors)) / data_range;
    
    nrmse_errors(k) = param_nrmse * 100;
end

disp(nrmse_errors);
