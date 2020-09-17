classdef obstacle_detector < matlab.System
    % Untitled2 Add summary here
    %
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = public)
        v1_frame = [4 2];
        v2_frame = [4 2];  
        ego_frame = [4 2];
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

       function [mf_relative_distance,rf_relative_distance] = stepImpl(obj,v1_pos,v2_X,v2_Y,v2_psi,ego_X,ego_Y,ego_psi)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
                if(check_inRange(obj.v1_frame,v1_pos,obj.ego_frame,[ego_X ego_Y ego_psi])==2)
                    distance1 = sqrt((v1_pos(1,1)-ego_X)^2+(v1_pos(2,1)-ego_Y)^2);
                else
                    distance1 = 1000;
                end
                if(check_inRange(obj.v2_frame,[v2_X v2_Y v2_psi],obj.ego_frame,[ego_X ego_Y ego_psi])==2)
                    distance2 = sqrt((v2_X-ego_X)^2+(v2_Y-ego_Y)^2);
                else
                    distance2 = 1000;
                end
                
                
                mf_relative_distance = min(distance1,distance2);
                
                if(check_inRange(obj.v1_frame,v1_pos,obj.ego_frame,[ego_X ego_Y ego_psi])==1)
                    distance1 = sqrt((v1_pos(1,1)-ego_X)^2+(v1_pos(2,1)-ego_Y)^2);
                else
                    distance1 = 1000;
                end
                if(check_inRange(obj.v2_frame,[v2_X v2_Y v2_psi],obj.ego_frame,[ego_X ego_Y ego_psi])==1)
                    distance2 = sqrt((v2_X-ego_X)^2+(v2_Y-ego_Y)^2);
                else
                    distance2 = 1000;
                end
                
                
                rf_relative_distance = min(distance1,distance2);


       end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
