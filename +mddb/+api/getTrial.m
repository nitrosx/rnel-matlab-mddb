%
%
function [trial,extras] = getTrial(tid,sbj)
    % function [trial,extras] = mddb.api.getTrial(tid,sbj)
    %
    % retrieve trial info given rnel trial id and subject name or id
    % alias for getTrialById function
    %
    % inputs
    % - (integer) tid = RNEL trial id
    % - (string)  sbj = subject name
    %   or
    % - (integer) sbj = subject id
    %
    %
    % outputs
    % - (struct) trial  = trial info
    % - (struct) extras = extra information returned by mddb
    %
    
    % call mddb.api.getTrialById
    [trial,tExtras] = mddb.api.getTrialById(tid,sbj);
    
    % check if we need to pass back extras too
    if nargout > 1
        extras = tExtras;
    end %if
end %function