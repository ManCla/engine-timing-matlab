%{
Inputs:
     - test_duration: duration of simulation
     - dt: sampling time of sim output (NOTE: Simulink uses a variable time step for the simulation)
     - speed_setpoint: speed valus over time (two comlumns: time and values)
     - drag_torque_load: load torque values over time (two comlumns: time and values)
%}

function output = run_sldemo_enginewc(test_duration,dt,speed_setpoint,drag_torque_load)

    simlk_filename = "sldemo_enginewc";

    % controller parameters
    Kp =0.0614;
    Ki = 0.0723;
    % Kp = [0.05 0.033 0.061];
    % Ki = [0.10 0.064 0.072];


    % create simulation input object and fill it with the needed values
    simIn = Simulink.SimulationInput(simlk_filename);
    simIn = setVariable(simIn,'Kp',Kp,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'Ki',Ki,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'test_duration',test_duration,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'dt',dt,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'speed_setpoint',speed_setpoint,'Workspace',simlk_filename);
    simIn = setVariable(simIn,'drag_torque_load',drag_torque_load,'Workspace',simlk_filename);

    % need to either send the variables as simulation input to the simulink
    % model or to change the scope of the simulink model to this function
    sim_output = sim(simIn);
    speed_output = sim_output.speed_output;
    output = speed_output;

end
