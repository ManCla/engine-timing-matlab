function output = run_sldemo_enginewc()

    simlk_filename = "sldemo_enginewc";

    % simulation parameters
    test_duration = 10;

    % controller parameters
    Kp =0.0614;
    Ki = 0.0723;
    % Kp = [0.05 0.033 0.061];
    % Ki = [0.10 0.064 0.072];

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

    % create simulation input object and fill it with the needed values
    simIn = Simulink.SimulationInput(simlk_filename);
    simIn = setVariable(simIn,'Kp',Kp,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'Ki',Ki,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'test_duration',test_duration,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'speed_setpoint',speed_setpoint,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'drag_torque_load',drag_torque_load,'Workspace',simlk_filename);

    % need to either send the variables as simulation input to the simulink
    % model or to change the scope of the simulink model to this function
    sim_output = sim(simIn);
    speed_output = sim_output.speed_output.Data;
    time_output = sim_output.speed_output.Time;
    output = [time_output, speed_output];

end
