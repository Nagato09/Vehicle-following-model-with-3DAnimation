classdef trajectory_generator < matlab.System & matlab.system.mixin.Propagates & matlab.system.mixin.SampleTime
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
    properties(Access = private)
        a0=[];
        a1=0;
        a2=0;
        a3=0;
        a4=0;
        a5=0;
        target_point=[];
        flag=0;
        dt=0.1;%sample time of the control signal
        T=0;%time duration of the whole lane-switch procss
        start_time=0;
        Model_Name='VehicleFollowing';
        
    end
    
    methods(Access = protected)
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
          
        end
        
        function  [is_finish,yaw_angle] = stepImpl(obj,current_point,v_x,v_y,a_y,drivingMode)
            % Implement algorithm. Calculate y as a function of input u and
            % discrete states.
            
%left lane switch
            if((drivingMode==4)&&(obj.flag==0))
                is_finish = 0;
                obj.flag=1;
                obj.target_point=current_point+[50 2.55];
                obj.start_time=get_param(obj.Model_Name,'SimulationTime');
            end
%right lane switch
            if((drivingMode==5)&&(obj.flag==0))
                is_finish = 0;
                obj.flag=1;
                obj.target_point=current_point+[50 -2.55];
                obj.start_time=get_param(obj.Model_Name,'SimulationTime');
            end
            %% Waypoint generation
            if(isempty(obj.a0)&&(obj.flag==1))
            obj.T = abs(obj.target_point(1,1)-current_point(1,1))/v_x;
            obj.a0=current_point(1,2);
            obj.a1=0;
            obj.a2=0;
            
            x_f = obj.target_point(1,1); % Final x coordinate
            y_f = obj.target_point(1,2); % Final y coordinate

            %%  Minimun jerk trajectory function for the calculation in y direction (Lateral)
           
            syms a3 a4 a5;
            [a3,a4,a5]=solve([obj.a0+obj.a1*obj.T+obj.a2*obj.T^2+a3*obj.T^3+a4*obj.T^4+a5*obj.T^5==y_f, ... % Boundary condition for lateral displacement
                obj.a1+2*obj.a2*obj.T+3*a3*obj.T^2+4*a4*obj.T^3+5*a5*obj.T^4==0, ...              % Boundary condition for lateral speed
                2*obj.a2+6*a3*obj.T+12*a4*obj.T^2+20*a5*obj.T^3==0,],[a3,a4,a5]);    % Boundary condition for lateral acceleration
            
            % Solving for coefficients and conversion to double precision
            obj.a3=double(a3);
            obj.a4=double(a4);
            obj.a5=double(a5);
            end
            
            %% Vehicle next state in x direction (Longitudinal)
            
%             x=current_point(1,1) + obj.dt*v_x;
             x_dot=v_x;
%             x_ddot=0;
%             
%             nextState_x=[x;x_dot;x_ddot];
            

             time=get_param(obj.Model_Name,'SimulationTime');
            %% Vehicle states in y direction
            if(time<=obj.start_time+obj.T)
%             y=[];
%             y_dot=[];
%             y_ddot=[];
            if(time<obj.start_time+obj.T)
                is_finish=0;
            else
                is_finish=1;            
            end
            t=time-obj.start_time;
%             y       = obj.a0+obj.a1*t+obj.a2*t^2+obj.a3*t^3+obj.a4*t^4+obj.a5*t^5;
            y_dot   = obj.a1+2*obj.a2*t+3*obj.a3*t^2+4*obj.a4*t^3+5*obj.a5*t^4;
%             y_ddot  = 2*obj.a2+6*obj.a3*t+12*obj.a4*t^2+20*obj.a5*t^3;
            
%             nextState_y=[y;y_dot;y_ddot];
            
            %% Yaw angle reference
            yaw_angle=atan(y_dot/ x_dot);        
            else
                obj.a0=[];
                obj.flag=0;
                obj.T=0;
                yaw_angle=0;
                is_finish = 1;
            end
            end


        function resetImpl(~)
            % Initialize / reset discrete-state properties
        end

        function [out,out2] = getOutputSizeImpl(~)
            % Return size for each output port
            out = [1 1];
            out2 = [1 1];

            % Example: inherit size from first input port
            % out = propagatedInputSize(obj,1);
        end

        function [out,out2] = getOutputDataTypeImpl(~)
            % Return data type for each output port
            out = "double";
            out2 = "double";

            % Example: inherit data type from first input port
            % out = propagatedInputDataType(obj,1);
        end

        function [out,out2] = isOutputComplexImpl(~)
            % Return true for each output port with complex data
            out = false;
            out2 = false;

            % Example: inherit complexity from first input port
            % out = propagatedInputComplexity(obj,1);
        end

        function [out,out2] = isOutputFixedSizeImpl(~)
            % Return true for each output port with fixed size
            out = true;
            out2 = true;

            % Example: inherit fixed-size status from first input port
            % out = propagatedInputFixedSize(obj,1);
        end

        function sts = getSampleTimeImpl(obj)
            % Define sample time type and parameters
            sts = obj.createSampleTime("Type", "Discrete", "SampleTime", 0.1);

            % Example: specify discrete sample time
            % sts = obj.createSampleTime("Type", "Discrete", ...
            %     "SampleTime", 1);
        end
    end
end
