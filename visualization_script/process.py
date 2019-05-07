import os, sys
import shutil
import math
import numpy as np

import matplotlib
import matplotlib.pyplot as plt
from matplotlib import rcParams as parameters
from matplotlib import ticker, cm, colors

columns = 127
parameters['savefig.dpi'] = 1200
parameters['savefig.transparent'] = False
parameters['savefig.format'] = 'svg'
colourbar_label_fontsize = 16 # default is 10

input_dir_name = "xy-1"
sorted_dir_name = "sorted"
render_dir_name = "render"

BASE_DIR = os.path.dirname(os.path.realpath(__file__))
INPUT_DIR = os.path.join(BASE_DIR, input_dir_name)
SORTED_DIR = os.path.join(BASE_DIR, sorted_dir_name)
RENDER_DIR = os.path.join(BASE_DIR, render_dir_name)

def make_dir (path):
	try:
		os.makedirs(path)
	except OSError:
		print ("Creation of the directory %s failed" % path)

def sort_files ():
	make_dir(SORTED_DIR)
	make_dir(RENDER_DIR)

	solutes = []
	for filename in os.listdir(INPUT_DIR):
		solute = filename.split(" ")[0]
		timeframe = filename.split(" ")[-1]
		SOLUTE_DIR = os.path.join(SORTED_DIR, solute)
		if solute in solutes:
			pass
		else:
			solutes.append(solute)
			make_dir (SOLUTE_DIR)

		shutil.copy2(
			os.path.join(INPUT_DIR, filename),
			os.path.join(SOLUTE_DIR, timeframe)
			)

def process_solute_data (input_dir, solute_name):
	SOLUTE_INPUT_DIR = input_dir
	SOLUTE_RENDER_DIR = os.path.join(RENDER_DIR,solute_name)
	make_dir(SOLUTE_RENDER_DIR)
	print (solute_name)

	concentation_scale_max = 0
	concentation_scale_min = math.inf

	for filename in os.listdir(SOLUTE_INPUT_DIR):
		concentrations = np.loadtxt (os.path.join (SOLUTE_INPUT_DIR, filename))
		#print (concentrations)
		concentation_scale_max = max(concentation_scale_max, np.max(concentrations))
		try:
			concentation_scale_min = min(concentation_scale_min, np.min(concentrations[np.nonzero(concentrations)]))
		except:
			print ("No non-zero elements")

	if concentation_scale_max == 0.0:
		pass
	else:

		scale_levels = np.power(10, 
			np.arange(
					np.floor(np.log10(concentation_scale_min) - 1), 
					np.ceil (np.log10(concentation_scale_max) + 1)
					)
			)

		for filename in os.listdir(SOLUTE_INPUT_DIR):
			solute_input_file = os.path.join (SOLUTE_INPUT_DIR, filename)
			output_basename = filename.split('.')[0] + '.' + parameters['savefig.format']
			solute_output_file = os.path.join (SOLUTE_RENDER_DIR, output_basename)

			print ('\t', solute_input_file)
			print ('\t', solute_output_file)

			# dummy plase holder to create the x,y coordinates
			X, Y = np.meshgrid(
				np.linspace(0,columns,columns),
				np.linspace(0,columns,columns)
			)

			# read data from txt file
			Z = np.loadtxt(solute_input_file, dtype=float, usecols=range(columns))

			# figure and axis
			fig, ax = plt.subplots()
			cs = ax.contourf(X, Y, Z, scale_levels, norm=colors.LogNorm())
			cbar = fig.colorbar(cs)
			cbar.ax.tick_params(labelsize=colourbar_label_fontsize) 

			# hide axis labels
			ax.xaxis.set_visible(False)
			ax.yaxis.set_visible(False)

			# Title definition. To have image without title - comment following line:
			# plt.title(solute)

			# Save the plot
			plt.savefig(solute_output_file, transparent=False)
			# Close the figure.
			# Otherwise recursion error will happpen !!!
			plt.close()


if __name__ == "__main__":
	sort_files()
	for solute in os.listdir(SORTED_DIR):
		process_solute_data (os.path.join(SORTED_DIR, solute), solute) 