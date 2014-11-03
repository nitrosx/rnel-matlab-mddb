%
%
classdef mddb
    
    %
    properties (Constant = true)
        % mddb services base url
        % production
        base = 'http://150.212.179.229/prod/rneldb/services';
        % local production
        %base = 'http://localhost/rneldb/lprod/instance/services';
        % parameters allowed in trial query
        qTrial = { ...
            'nid', ...
            'trial','trialid','tid', ...
            'session','sessionid', ...
            'subject','subjectname','sbjname', ...
            'subjectid','sbjid', ...
            'type', ...
            'typeid', ...
            'date', ...
            'format' };
    end % properties
    
    %
    methods (Static = true)
        %
        function init()
            % function init()
            %
            % initialize the mddb api class
            % most important load some of the java library upfront
            % to avoid running javaaddpath while being used
            % apparently javaaddpath clear all the global variables
            % screwing up our setup and data loaded in memory
            
            try
                % import yaml java library
                import('org.yaml.snakeyaml.*');
                test = javaObject('org.yaml.snakeyaml.Yaml');
            catch
                % no luck
                % find full path of this yaml library
                [path,~,~] = fileparts(mfilename('fullpath'));       
                % build path to jar library
                jarpath = [path filesep 'external' filesep 'snakeyaml-1.9.jar'];
                if not(ismember(jarpath, javaclasspath ('-dynamic')))
                    % add path to java library
                	javaaddpath(jarpath); % javaaddpath clears global variables...!?
                end
                % import java library
                import('org.yaml.snakeyaml.*');
            end; % try/catch            
        end %function
        %
        function url = url(which)
            % function url = mddb.url(which)
            %
            % return the url of the service requested
            %
            % input 
            % - (string) which = which url we are requesting
            %   Possible values:
            %   * base   = base url for services. Default
            %   * trials = trial web services url
            
            % check if which has been passed
            if ( nargin < 1 )
                % no argumnet in 
                which = 'base'
            end %if
            % just in case, convert to lower case
            which = lower(which);
            
            % set output to default url
            url = mddb.base;
            % find the right url
            switch (which)
                case 'trial'
                    % trial
                    url = [url '/trial'];
                otherwise
                    % base
                    %
                    
            end %switch            
        end %function
        
        function list = queryParameters(which)
            % function list = mddb.queryParameters(which)
            %
            % return the list of query parameters allowed
            %
            % input
            % - (string) which = which list are we interested on
            
            % check if which has been passed
            if ( nargin < 1 )
                % no argumnet in 
                which = 'none'
            end %if
            % just in case, convert to lower case
            which = lower(which);
            
            % initialize list
            list = {};
            % find the list
            switch (which)
                case 'trial'
                    list = mddb.qTrial;
            end %switch
        end %function
        
    end % methods

end %classdef
