classdef command_generator < matlab.System
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

        function command = stepImpl(obj,mf_d,lf_d)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            if((mf_d<30)&&(lf_d>50))
                command = 0x01;
                return;
            else
                command = 0x00;
            end
        end

        function resetImpl(obj)
            % Initialize / reset discrete-state properties
        end
    end
end
