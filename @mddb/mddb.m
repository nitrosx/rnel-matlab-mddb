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
