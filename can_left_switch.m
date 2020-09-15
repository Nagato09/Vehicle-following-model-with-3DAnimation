classdef can_left_switch < matlab.System
    % untitled Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = private)

    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function can_left_switch = stepImpl(obj,ego_info,v1_info,v2_info)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
            %perception information
            ego_lane = ego_info(1,1);
%             ego_X = ego_info(1,2);
%             ego_Y= ego_info(1,3);
%             ego_speed = ego_info(1,5);
            
            v1_lane = v1_info(1,1);
%             v1_X = v1_info(1,2);
%             v1_Y= v1_info(1,3);
%             v1_speed = v1_info(1,5);
            
            v2_lane = v2_info(1,1);
%             v2_X = v2_info(1,2);
%             v2_Y= v2_info(1,3);
%             v2_speed = v2_info(1,5);
            
            %find vehicles on the same lane
            if(v1_lane == ego_lane)
                most_important_vehicle = v1_info;
                if (v2)
            end
            
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
