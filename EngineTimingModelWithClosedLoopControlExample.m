%% Engine Timing Model with Closed Loop Control
%
% This example shows how to enhance a version of the open-loop engine model
% described in <docid:simulink_ref#example-sldemo_engine Modeling Engine
% Timing Using Triggered Subsystems>. This model, |sldemo_enginewc|,
% contains a closed-loop and shows the flexibility and extensibility of
% Simulink(R) models. In this enhanced model, the objective of the
% controller is to regulate engine speed with a fast throttle actuator,
% such that changes in load torque have minimal effect. This is easily
% accomplished in Simulink by adding a discrete-time PI controller to the
% engine model.

% Copyright 2006-2016 The MathWorks, Inc.

%% Closed-Loop Model
%
% We chose a control law which uses proportional plus integral (PI)
% control. The integrator is needed to adjust the steady-state throttle as
% the operating point changes, and the proportional term compensates for
% phase lag introduced by the integrator. 
%
%% 
% *Equation 1*
%
% $$ \theta = K_{\rho}(N_{set}-N) + K_I \int (N_{set}-N) dt $$
%
% $$ N_{set} = \mbox{ speed set point (rpm) } $$
%
% $$ K_{\rho} = \mbox{ proportional gain } $$
%
% $$ K_I = \mbox{ integral gain } $$


%% Running the Simulation
%
% Press the "Play" button on the model toolbar to run the simulation.
%
% * Note: The model logs relevant data to MATLAB workspace in a structure
% called |sldemo_enginewc_output|. Logged signals have a blue indicator.
% Read more about Signal Logging in Simulink Help.

open_system('sldemo_enginewc');   % hidden code, not displayed in HTML example page
evalc('sim(''sldemo_enginewc'')');  % run simulation, don't display output

%%
% *Figure 1:* Closed-loop engine model and simulation results

%%
% 
% In this model we employ a discrete-time controller, which is suitable for
% microprocessor implementation. The integral term in Equation 1 must thus
% be realized with a discrete-time approximation. As is typical in the
% industry, the controller execution is synchronized with the engine's
% crankshaft rotation. The controller is embedded in a triggered subsystem
% that is triggered by the valve timing signal described above.
%
% The detailed construction of the 'Controller' subsystem is illustrated in
% Figure 2. Of note is the use of the 'PID Controller' block.  This block
% implements a proportional-integral control system in discrete time.  Note
% the setting for sample time set (internally) at |-1|.  This indicates
% that the block inherits its sample time, in this case executing each time
% the subsystem is triggered. The key component that makes this a triggered
% subsystem is the 'Trigger' block shown at the bottom of Figure 2. Any
% subsystem can be converted to a triggered subsystem by dragging a copy of
% this block into the subsystem diagram from the Simulink Connections
% library.

open_system('sldemo_enginewc/Controller');

%%
% *Figure 2:* Speed controller subsystem

%% Results 
%
% Typical simulation results are shown in Figure 3. The speed set point
% steps from |2000 rpm| to |3000 rpm| at |t = 5 sec|. The torque
% disturbances are identical to those used in |sldemo_engine|, the
% open-loop model. Note the quick transient response, with zero steady-state
% error. Several alternative controller tunings (|Ki| and |Kp|) are shown.
% These can be adjusted by the user at MATLAB command line. This allows the
% engineer to understand the relative effects of parameter variations.

% Close the scopes before running 3 simulations in a row.
% This prevents unwanted scope images from showing up in the HTML.

close_system('sldemo_enginewc/EngineSpeed');
close_system('sldemo_enginewc/SimulationInputs');
clear Kp Ki;
% 3 different sets of Ki and Kp parameters
Param.Kp = [0.05 0.033 0.061];
Param.Ki = [0.10 0.064 0.072];
% run the simulation three times with these different parameters 
% save the EngineSpeed data every time

for i=1:3
    Kp = Param.Kp(i);
    Ki = Param.Ki(i);
    evalc('sim(''sldemo_enginewc'')');
    x{i} = sldemo_enginewc_output.get('EngineSpeed').Values.Time; % x-axis data
    y{i} = sldemo_enginewc_output.get('EngineSpeed').Values.Data; % y-axis data
end


PlotHandle = plot(x{1}, y{1}, 'b-',  ...
                  x{2}, y{2}, 'b:', ...
                  x{3}, y{3}, 'b-.');
              
title('Closed-Loop Simulation Results: Engine Speed (rpm)');
xlabel('Time (sec)'); ylabel('Engine Speed (rpm)');
set(gca,'Color','k','XGrid','On','XColor',[0.3 0.3 0.3],...
                    'YGrid','On','YColor',[0.3 0.3 0.3]);
axis([0 10 1950 3150]);
h = legend( ['Kp = ' num2str(Param.Kp(1)) ', Ki = ' num2str(Param.Ki(1))], ...
            ['Kp = ' num2str(Param.Kp(2)) ', Ki = ' num2str(Param.Ki(2))], ...
            ['Kp = ' num2str(Param.Kp(3)) ', Ki = ' num2str(Param.Ki(3))], ...
            'Location','SouthEast');
        
set(h,'TextColor','w','Color','none'); 

%%
%
% *Figure 3:* Typical simulation results

%% Closing Model
% 
% Close the model. Clear logged data.

close_system('sldemo_enginewc', 0);
clear sldemo_enginewc_output Ki Kp h PlotHandle Param x y i; %clear unnecessary variables
%% Conclusions 
%
% The ability to model nonlinear, complex systems, such as the engine model
% described here, is one of Simulink's key features. The power of the
% simulation is evident in the presentation of the models above. Simulink
% retains model fidelity, including precisely timed cylinder intake events,
% which is critical in creating a model of this type. The complete speed
% control system shows the flexibility of Simulink. In particular, the
% Simulink modeling approaches allow rapid prototyping of an
% interrupt-driven engine speed controller.
%
%% References
%
% [1] P.R. Crossley and J.A. Cook, IEEE(R) International Conference 'Control
% 91', Conference Publication 332, vol. 2, pp. 921-925, 25-28 March, 1991,
% Edinburgh, U.K. 
%
% [2] The Simulink Model. Developed by Ken Butts, Ford Motor Company(R).
% Modified by Paul Barnard, Ted Liefeld and Stan Quinn, MathWorks(R), 1994-7. 
%
% [3] J. J. Moskwa and J. K. Hedrick, "Automotive Engine
% Modeling for Real Time Control Application," Proc.1987 ACC, pp. 341-346.
% 
% [4] B. K. Powell and J. A. Cook, "Nonlinear Low Frequency
% Phenomenological Engine Modeling and Analysis," Proc. 1987 ACC, pp.
% 332-340. 
%
% [5] R. W. Weeks and J. J. Moskwa, "Automotive Engine Modeling for
% Real-Time Control Using Matlab/Simulink," 1995 SAE Intl. Cong. paper
% 950417.
