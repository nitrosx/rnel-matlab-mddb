%
%
function [ids,extras] = getTrialsId(query)
    % function [ids,extras] = mddb.api.getTrialsId(query)
    %
    % retrieve trials id list according to query values
    %
    % inputs
    % - (struct) query = structure containing the parameters for the query
    %
    %   List of available parameters:
    %   * nid 
    %     comma separated list of values or ranges of trial node ids.
    %     if specified, overrides all the other parameters.
    %
    %   * trial (trialid,tid)
    %     comma separated list of values or ranges of trial ids
    %     it should be used together with subject or subjectid, 
    %     to narrow only the trials from a specific subject
    %
    %   * session (sessionid)
    %     comma separated list of values or ranges of sessions ids
    %
    %   * subject (subjectname,sbjname)
    %     comma separated list of strings indicating the names of the subjects to select
    %     this parameter takes precedence over subjectid
    %
    %   * subjectid (sbjid)
    %     comma separated list of values or ranges of rnel subject ids
    %     this parameter is ignored if subject is provided
    %
    %   * type
    %     comma separated list of trial type names
    %     spaces are converted to html equivalent
    %
    %   * typeid
    %     comma separated list of trial type nids (Drupal node id)
    %
    %   * date
    %     comma separated list of values or one range of dates when the trial was done
    %     it can be used with all the other parameters
    %     format: YYYYMMDD
    %
    % outputs
    % - (struct/array) ids    = list of trials ids
    % - (struct)       extras = extra information returned by mddb
    %

    % set format to ids
    query.format = 'ids';
    
    % calls getTrials
    [ids,tExtras] = mddb.api.getTrials(query);
    
    %
    % check if we are required to provide extra info
    if ( nargout >1 ) 
        % prepares extras with additional info from output and info
        extras = tExtras;
    end %if
end %function