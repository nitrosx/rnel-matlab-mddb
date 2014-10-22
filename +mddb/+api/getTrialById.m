%
%
function [trial,extras] = getTrialById(tid,sbj)
    % function [trial,extras] = mddb.api.getTrialById(tid,sbj)
    %
    % retrieve trial info given rnel trial id and subject name or id
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

    % retrieve url of mddb
    % for now is stored in the mddb class url static method
    url = mddb.url('trial');
    % query parameter separator
    qs = '&';
    
    % initialize the query url qith the base url
    qurl = url;
    % check trial id
    if ~isnumeric(tid)
        throw(MException('mddb:api','Invalid trial id.'));
    end %if
    % add trial id
    qurl = [qurl '.yaml?trialid=' urlencode(num2str(tid))];
    % check if subject is strin gor integer
    if ischar(sbj)
        % we got the subject name
        qurl = [qurl '&subject=' urlencode(sbj)];
    elseif isnumeric(sbj)
        % we got the subject id
        qurl = [qurl '&subjectid=' urlencode(num2str(sbj))];
    else 
        % we got nothign usable
        throw(MException('mddb:api','Invalid subject info.'));
    end %if
    % add output format
    qurl = [qurl '&format=full'];
    
    % send request
    [getRes,info] = mddb.lib.urlread2.urlread2(qurl);
    % convert results in matlab struct
    sRes = mddb.lib.yaml.ParseYaml(getRes);
    % extract data section
    % we should have only one trial returned, but just in case we return
    % only the first one
    trial = sRes.trials{1};
    %
    % check if we are required to provide extra info
    if ( nargout >1 ) 
        % prepares extras with additional info from output and info
        extras = info;
        extras.query = sRes.query;
        extras.format = sRes.format;
        extras.records = length(sRes.trials);
    end %if
end %function