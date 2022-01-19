% make sure the OpenFAST directory where the FAST_SFunc.mex* file is located
% is in the MATLAB path (also make sure any other OpenFAST library files that
% are needed are on the MATLAB path)
%    (relative path names are not recommended in addpath()):
% addpath('../../../build/bin'); % install location for Windows Visual Studio builds
% addpath(genpath('../../../install')); % cmake default install location

% these variables are defined in the OpenLoop model's FAST_SFunc block:
FAST_InputFileName = './report_data/5MW_OC4Semi_WSt_WavesWN_base/5MW_OC4Semi_WSt_WavesWN.fst';
% FAST_InputFileName = './report_data/StC_test_OC4Semi_wind/StC_test_OC4Semi.fst';
% FAST_InputFileName = './report_data/StC_test_OC4Semi_waves/StC_test_OC4Semi.fst';
% FAST_InputFileName = './report_data/StC_test_OC4Semi_wind_waves/StC_test_OC4Semi.fst';
TMax               = 60; % seconds

% sim('hybrid_test.slx',[0,TMax]);
sim('OpenLoop.mdl', [0,TMax]);