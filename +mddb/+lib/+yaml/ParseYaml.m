%==========================================================================
% Read a yaml string and returns a matlab struct
%
% Input:
%   yamlIn           ... yaml string in input
%
% Output:
%   yamlOut          ... yaml as matlab struct
%
function yamlOut = ParseYaml(yamlIn,makeords,dictionary)
    % function yamlOut = mddb.lib.yaml.ParseYaml(yamlIn,makeords,dictionary)
    %
    % convert yaml string in to matlab structure
    %
    % input
    % - (string)  yamlIn
    % - ( ? )     makeords
    % - ((struct) dictionary
    %

    % instantiate yaml java object
    yaml = org.yaml.snakeyaml.Yaml(); % It appears that Java objects cannot be persistent...!?
    % load our yaml in the instance
    jYaml = yaml.load(yamlIn);
    % scan the object and transform it to matlab struct
    yo = mddb.lib.yaml.scan_yaml(jYaml);
    % does some other magic
    yo = mddb.lib.yaml.deflateimports(yo);
    if iscell(yo) && ...
        length(yo) == 1 && ...
        isstruct(yo{1}) && ...
        length(fields(yo{1})) == 1 && ...
        isfield(yo{1},'import')        
        yo = yo{1};
    end; %if
    yo = mddb.lib.yaml.mergeimports(yo);    
    yo = mddb.lib.yaml.doinheritance(yo);
    if exist('makeords','var')
        yo = mddb.lib.yaml.makematrices(yo, makeords);    
    end; %if
    if exist('dictionary','var')
        yo = mddb.lib.yaml.dosubstitution(yo, dictionary);
    end; %if
    
    yamlOut = yo;

end % function
