import numpy as np
import matlab.engine
import matplotlib.pyplot as plt

# start matlab engine
eng = matlab.engine.start_matlab()
print("Matlab Engine Started")

# define inputs
# NOTE: - for matlab it is important that they are doubles (hence defined with the .0)
#       - arrays need to be cast to matlab arrays
#       - arrays that specify values over time need the time and value columns
test_duration = 10.0
dt = 0.001
speed_setpoint = matlab.double([[0,2000],
                  [4.99,2000],
                  [5,3000],
                  [10,3000]])
drag_torque_load = matlab.double([[0,10],
                    [3,10],
                    [3.01,25],
                    [7,25],
                    [7.01,15],
                    [10,15]])

# run simulink model
out = eng.run_sldemo_enginewc(test_duration,dt,speed_setpoint,drag_torque_load)
# convert matlab array to numpy array
out = np.array(out)
# plot the results
plt.plot(out)
plt.show()

# close matlab engine
eng.quit()
