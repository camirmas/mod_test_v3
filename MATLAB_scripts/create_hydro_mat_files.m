function create_hydro_mat_files(filename, output_file_suffix)

[all_data, params] = ReadFASTbinary(filename);

% extract time and forces/moments
time = all_data(:,1);
% PtfmSurge = all_data(:, find(strcmp(params, 'HydroFxi')));
% PtfmSway = all_data(:, find(strcmp(params, 'HydroFyi')));
% PtfmHeave = all_data(:, find(strcmp(params, 'HydroFzi')));
% PtfmRoll = all_data(:, find(strcmp(params, 'HydroMxi')));
% PtfmPitch = all_data(:, find(strcmp(params, 'HydroMyi')));
% PtfmYaw = all_data(:, find(strcmp(params, 'HydroMzi')));

B1AddFxi = all_data(:, find(strcmp(params, 'B1AddFxi')));
B1AddFyi = all_data(:, find(strcmp(params, 'B1AddFyi')));
B1AddFzi = all_data(:, find(strcmp(params, 'B1AddFzi')));
B1AddMxi = all_data(:, find(strcmp(params, 'B1AddMxi')));
B1AddMyi = all_data(:, find(strcmp(params, 'B1AddMyi')));
B1AddMzi = all_data(:, find(strcmp(params, 'B1AddMzi')));
B1WvsFxi = all_data(:, find(strcmp(params, 'B1WvsFxi')));
B1WvsFyi = all_data(:, find(strcmp(params, 'B1WvsFyi')));
B1WvsFzi = all_data(:, find(strcmp(params, 'B1WvsFzi')));
B1WvsMxi = all_data(:, find(strcmp(params, 'B1WvsMxi')));
B1WvsMyi = all_data(:, find(strcmp(params, 'B1WvsMyi')));
B1WvsMzi = all_data(:, find(strcmp(params, 'B1WvsMzi')));
B1HdSFxi = all_data(:, find(strcmp(params, 'B1HdSFxi')));
B1HdSFyi = all_data(:, find(strcmp(params, 'B1HdSFyi')));
B1HdSFzi = all_data(:, find(strcmp(params, 'B1HdSFzi')));
B1HdSMxi = all_data(:, find(strcmp(params, 'B1HdSMxi')));
B1HdSMyi = all_data(:, find(strcmp(params, 'B1HdSMyi')));
B1HdSMzi = all_data(:, find(strcmp(params, 'B1HdSMzi')));
B1RdtFxi = all_data(:, find(strcmp(params, 'B1RdtFxi')));
B1RdtFyi = all_data(:, find(strcmp(params, 'B1RdtFyi')));
B1RdtFzi = all_data(:, find(strcmp(params, 'B1RdtFzi')));
B1RdtMxi = all_data(:, find(strcmp(params, 'B1RdtMxi')));
B1RdtMyi = all_data(:, find(strcmp(params, 'B1RdtMyi')));
B1RdtMzi = all_data(:, find(strcmp(params, 'B1RdtMzi')));


PtfmSurge = B1AddFxi + B1WvsFxi + B1HdSFxi + B1RdtFxi;
PtfmSway = B1AddFyi + B1WvsFyi + B1HdSFyi + B1RdtFyi;
PtfmHeave = B1AddFzi + B1WvsFzi + B1HdSFzi + B1RdtFzi;
PtfmRoll = B1AddMxi + B1WvsMxi + B1HdSMxi + B1RdtMxi;
PtfmPitch = B1AddMyi + B1WvsMyi + B1HdSMyi + B1RdtMyi;
PtfmYaw = B1AddMzi + B1WvsMzi + B1HdSMzi + B1RdtMzi;


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
save(['../report_data/MAT/hydro/PtfmSurge_',output_file_suffix,'.mat'], 'PtfmSurge')
save(['../report_data/MAT/hydro/PtfmSway_',output_file_suffix,'.mat'], 'PtfmSway')
save(['../report_data/MAT/hydro/PtfmHeave_',output_file_suffix,'.mat'], 'PtfmHeave')
save(['../report_data/MAT/hydro/PtfmPitch_',output_file_suffix,'.mat'], 'PtfmPitch')
save(['../report_data/MAT/hydro/PtfmRoll_',output_file_suffix,'.mat'], 'PtfmRoll')
save(['../report_data/MAT/hydro/PtfmYaw_',output_file_suffix,'.mat'], 'PtfmYaw')