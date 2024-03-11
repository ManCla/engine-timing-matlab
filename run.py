import numpy as np
import matlab.engine
import matplotlib.pyplot as plt

# start matlab engine
eng = matlab.engine.start_matlab()
print(" -- Matlab Engine Started")

# define inputs
# NOTE: - for matlab it is important that they are doubles (hence defined with the .0)
#       - arrays need to be cast to matlab arrays
#       - matlab function will add the time steps to the input arrays
test_duration = 10.0
dt = 0.001
n_steps = int(test_duration/dt)+1
speed_setpoint = np.concatenate((2000*np.ones((5000)),
                                 3000*np.ones((5001))))
drag_torque_load = np.concatenate((10*np.ones((3000)),
                                   25*np.ones((4000)),
                                   15*np.ones((3001))))
speed_setpoint = matlab.double(speed_setpoint.transpose())
drag_torque_load = matlab.double(drag_torque_load.transpose())

# run simulink model
print(" -- Start running Simulink model")
out = eng.run_sldemo_enginewc(test_duration,dt,speed_setpoint,drag_torque_load)
print(" -- Finished running Simulink model")
# convert matlab array to numpy array
out = np.array(out)
# plot the results
plt.plot(out)
plt.show()

# close matlab engine
eng.quit()
print(" -- Matlab Engine Quitted")
