% script to call the function for the simulation directly from matlab
% useful for debugging

clear

% define inputs
test_duration = 10.0;
dt = 0.001;
speed_setpoint = [2000*ones(5000,1);
                  3000*ones(5001,1);
                 ];
drag_torque_load = [10*ones(3000,1);
                    25*ones(4000,1);
                    15*ones(3001,1);
                   ];

% call function
speed_output = run_sldemo_enginewc(test_duration,dt,speed_setpoint,drag_torque_load);

%plot output
time = 0:dt:test_duration;
plot(time,speed_output)
