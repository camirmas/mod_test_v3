function read_results(fname, txt)

if txt
    [all_data, params] = ReadFASTtext(fname);
else 
    [all_data, params] = ReadFASTbinary(fname);
end

fields = {'PtfmSurge', 'PtfmSway', 'PtfmHeave', 'PtfmPitch', 'PtfmRoll', ...
    'PtfmYaw'};%, 'PtfmTVxi', 'PtfmTVyi', 'PtfmTVzi', 'PtfmRVyi', 'PtfmRVxi', 'PtfmRVzi', 'RotSpeed'};

fields_read = {'PtfmSurge', 'PtfmSway', 'PtfmHeave', 'PtfmPitch', 'PtfmRoll', ...
    'PtfmYaw'}; %, 'PtfmSurgeVel', 'PtfmSwayVel', 'PtfmHeaveVel', 'PtfmPitchVel', ...
    %'PtfmRollVel', 'PtfmYawVel', 'RotSpeed'};

results = [];
for i=1:length(fields)
   idx = strcmp(params, fields(i));
   field = all_data(:, idx);
   results = [results field];
end

T = array2table(results, "VariableNames", fields_read);
writetable(T, "results_" + now + ".csv")