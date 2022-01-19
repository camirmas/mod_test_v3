% make sure the OpenFAST directory where the FAST_SFunc.mex* file is located
% is in the MATLAB path (also make sure any other OpenFAST library files that
% are needed are on the MATLAB path)
%    (relative path names are not recommended in addpath()):
% addpath('../../../build/bin'); % install location for Windows Visual Studio builds
% addpath(genpath('../../../install')); % cmake default install location

% these variables are defined in the OpenLoop model's FAST_SFunc block:

TMax               = 360; % seconds

disp('Running FAST Baseline');
FAST_InputFileName = '../report_data/5MW_OC4Semi_WSt_WavesWN_base/5MW_OC4Semi_WSt_WavesWN_FAST.fst';
sim('../open_loop_test.slx',[0,TMax]);

disp('Creating Hydro .mat files');
create_hydro_mat_files('../report_data/5MW_OC4Semi_WSt_WavesWN_base/5MW_OC4Semi_WSt_WavesWN_FAST.SFunc.outb', '5MW_OC4Semi_WSt_WavesWN');

disp('Running Hybrid model');
FAST_InputFileName = '../report_data/5MW_OC4Semi_WSt_WavesWN_base/5MW_OC4Semi_WSt_WavesWN_hybrid.fst';
sim('../open_loop_test.slx',[0,TMax]);

disp('Running error comparison');
movefile '../report_data/5MW_OC4Semi_WSt_WavesWN_base/*.outb' '../report_data/FAST_output_files'
SimulinkFAST_error_compare('../report_data/FAST_output_files');
