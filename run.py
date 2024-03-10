import numpy as np
import matlab.engine
import matplotlib.pyplot as plt

# start matlab engine
eng = matlab.engine.start_matlab()
print("Successfully started Matlab Engine")

# run simulink model
out = eng.run_sldemo_enginewc()
# convert matlab array to numpy array
out = np.array(out)
# plot the results
plt.plot(out[:,0],out[:,1])
plt.show()

# close matlab engine
eng.quit()
