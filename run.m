
% simulation duration
test_duration = 10;


% controller parameters
Kp =0.0614; Ki = 0.0723;
% Kp = [0.05 0.033 0.061];
% Ki = [0.10 0.064 0.072];
% Kp =0.0614; Ki = 0.0723;



speed_setpoint = [[0,2000];
                  [4.99,2000];
                  [5,3000]
                  [10,3000]];

drag_torque_load = [[0,10];
                    [3,10];
                    [3.01,25];
                    [7,25];
                    [7.01,15];
                    [10,15];];

sim("sldemo_enginewc.slx")

plot(speed_output)
