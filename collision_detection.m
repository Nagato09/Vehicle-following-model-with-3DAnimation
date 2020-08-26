classdef collision_detection < matlab.System
    % untitled Add summary here
    %This function detects rear-end collision, if collides, stop simulation
    % This template includes the minimum set of functions required
    % to define a System object with discrete state.

    % Public, tunable properties
    properties

    end

    properties(DiscreteState)

    end

    % Pre-computed constants
    properties(Access = public)
    v1_length = 4;%Vehicle longitudinal length
    v2_length = 4;
    v3_length = 4;
    v1_width = 2;%Vehicle lateral width
    v2_width = 2;
    v3_width = 2;
    end

    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
           
        end

        function collision = stepImpl(obj,v1_pos,v2_pos)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if(((v1_pos(1,1)-v2_pos(1,1))^2+(v1_pos(1,2)-v2_pos(1,2))^2)<300)
                if((check_collision(obj,v1_pos,v2_pos)==1))
                 collision = 1;
                else
                    collision=0;
                end
            else
                collision=0;
                return
            end
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
