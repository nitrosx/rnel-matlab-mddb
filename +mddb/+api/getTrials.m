%
%
function [results,extras] = getTrials(query)
    % function [trials,extras] = mddb.api.getTrials(query)
    %
    % retrieve trials list according to query values
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
    %   * format
    %     output format. Define what is returned.
    %     possible values: 
    %     - nids(default) = returns only the internal mddb node ids 
    %     - ids           = returns only the rnel trial id
    %     - object, full  = returns the full trial content in yaml format
    %
    % outputs
    % - (struct/array) trials = list of results
    % - (struct)       extras = extra information returned by mddb
    %

    % list of 
    
    % retrieve url of mddb
    % for now is stored in the mddb class url static method
    url = mddb.url('trial');
    % valid paramaters list
    vpl = mddb.queryParameters('trial');
    % query parameter separator
    qs = '&';
    
    % check if we got anything in input
    if nargin < 1 || ~isa(query,'struct')
        % nothing in input or query is not a struct
        query = struct();
    end %if
    
    % check parameters
    parameters = fieldnames(query);
    % verify parameters name
    verify = ismember(parameters,vpl);
    % filter invalid parameters
    vParams = parameters(verify);
    % initialize get query string
    gqs = '';
    % temp separator
    tsep = '';
    % cycle on the query parameters and builds the query string to append
    % at the get request
    for i = 1:numel(vParams)
        % get parameter value
        value = query.(vParams{i});
        % if it is not a string, transform it
        if ~isa(value,'char')
            value = num2str(value);
        end %if
        % encode both param name and value
        param = urlencode(vParams{i});
        value = urlencode(value);
        % add parameter and value to the get query string
        gqs = [gqs tsep param '=' value];
        % set separator after the first parameter
        tsep = qs;
    end %for
    % prepare the full url including the query if any
    qurl = [url '.yaml'];
    if ~isempty(gqs)
        qurl = [qurl '?' gqs];
    end %if
    % send request
    [getRes,info] = mddb.lib.urlread2.urlread2(qurl);
    % convert results in matlab struct
    sRes = mddb.lib.yaml.ParseYaml(getRes);
    % extract data section
    results = {};
    switch (sRes.format)
        case 'nids'
            results = sRes.nids;
        case 'ids'
            results = sRes.ids;
        case 'full'
            results = sRes.trials;
    end %switch
    %
    % check if we are required to provide extra info
    if ( nargout >1 ) 
        % prepares extras with additional info from output and info
        extras = info;
        extras.query = sRes.query;
        extras.format = sRes.format;
        extras.records = length(results);
    end %if
end %function