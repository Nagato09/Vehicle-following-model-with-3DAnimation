function [scenario, egoVehicle] = test()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.8 (R2020a) and Automated Driving Toolbox 3.1 (R2020a).
% Generated on: 06-Sep-2020 23:28:02

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [100 0.8 0;
    6 0.8 0];
road(scenario, roadCenters);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [10.1 0.2 0]);
waypoints = [10.1 0.2 0;
    20 0 0;
    30 0 0;
    44.3 0.1 0;
    59.7 -0.4 0];
speed = [30;20;10;10;10];
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [33.9 1.8 0]);
waypoints = [33.9 1.8 0;
    51.3 2.1 0;
    77.8 2.3 0];
speed = 30;
trajectory(car1, waypoints, speed);

