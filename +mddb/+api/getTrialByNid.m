%
%
function [trial,extras] = getTrialByNid(nid)
    % function [trial,extras] = mddb.api.getTrialByNid(nid)
    %
    % retrieve trial info given the internal mddb node id (nid)
    %
    % inputs
    % - (integer) nid = internal mddb node id of the trial
    %
    
    % retrieve url of mddb
    % for now is stored in the mddb class url static method
    url = mddb.url('trial');
    
    % prepare the full url including the query if any
    qurl = [url '/' num2str(nid) '.yaml'];
    % send request
    [getRes,info] = mddb.lib.urlread2.urlread2(qurl);
    % convert results in matlab struct
    trial = mddb.lib.yaml.ParseYaml(getRes);
    % check if we are required to provide extra info
    if ( nargout > 1 ) 
        % prepares extras with additional info from output and info
        extras = info;
    end %if
end %function