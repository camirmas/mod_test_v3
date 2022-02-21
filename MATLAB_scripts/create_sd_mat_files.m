function create_hydro_mat_files(filename, output_file_suffix)

[all_data, params] = ReadFASTbinary(filename);

% extract time and forces/moments
time = all_data(:,1);
PtfmSurge = all_data(:, find(strcmp(params, 'IntfFXss')));
PtfmSway = all_data(:, find(strcmp(params, 'IntfFYss')));
PtfmHeave = all_data(:, find(strcmp(params, 'IntfFZss')));
PtfmRoll = all_data(:, find(strcmp(params, 'IntfMXss')));
PtfmPitch = all_data(:, find(strcmp(params, 'IntfMYss')));
PtfmYaw = all_data(:, find(strcmp(params, 'IntfMZss')));

% shift forces/moments one time step ahead so they are now acting as inputs
% instead of outputs
PtfmSurge = [0; PtfmSurge(1:end-1)];
PtfmSway = [0; PtfmSway(1:end-1)];
PtfmHeave = [0; PtfmHeave(1:end-1)];
PtfmPitch = [0; PtfmPitch(1:end-1)];
PtfmRoll = [0; PtfmRoll(1:end-1)];
PtfmYaw = [0; PtfmYaw(1:end-1)];

% make everything into Simulink-readable format
PtfmSurge = [time'; PtfmSurge'];
PtfmSway = [time'; PtfmSway'];
PtfmHeave = [time'; PtfmHeave'];
PtfmPitch = [time'; PtfmPitch'];
PtfmRoll = [time'; PtfmRoll'];
PtfmYaw = [time'; PtfmYaw'];

% Save as MAT files
save(['../report_data/MAT/sd/PtfmSurge_',output_file_suffix,'.mat'], 'PtfmSurge')
save(['../report_data/MAT/sd/PtfmSway_',output_file_suffix,'.mat'], 'PtfmSway')
save(['../report_data/MAT/sd/PtfmHeave_',output_file_suffix,'.mat'], 'PtfmHeave')
save(['../report_data/MAT/sd/PtfmPitch_',output_file_suffix,'.mat'], 'PtfmPitch')
save(['../report_data/MAT/sd/PtfmRoll_',output_file_suffix,'.mat'], 'PtfmRoll')
save(['../report_data/MAT/sd/PtfmYaw_',output_file_suffix,'.mat'], 'PtfmYaw')