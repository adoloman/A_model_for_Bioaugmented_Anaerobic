# Scripts takes all *.xml file from agent_Sum folder
# and creates a plot to show the growth of each specie

# Author : Yehor Pererva

import os, sys
import shutil
import numpy as np
import csv
import xml.etree.ElementTree as ET

import matplotlib
import matplotlib.pyplot as plt
from matplotlib import rcParams as parameters
from matplotlib import ticker, cm, colors

columns = 127
parameters['savefig.dpi'] = 1200
parameters['savefig.transparent'] = False
parameters['savefig.format'] = 'png'

input_dir_name = "agent_Sum"
render_dir_name = "render"

BASE_DIR = os.path.dirname(os.path.realpath(__file__))
INPUT_DIR = os.path.join(BASE_DIR, input_dir_name)
RENDER_DIR = os.path.join(BASE_DIR, render_dir_name)

def make_dir (path):
	try:
		os.makedirs(path)
	except OSError:
		print ("Creation of the directory %s failed" % path)

data_array = []
labels = ['timestamp', ]

def collect_mass_data ():
	for file in os.listdir(INPUT_DIR):
		tree = ET.parse(os.path.join (INPUT_DIR, file))

		step_data = {}

		root = tree.getroot()
		timestamp = root.find('simulation').attrib['time']

		step_data['timestamp'] = float (timestamp)

		for specie in root.iter('species'):
			name = specie.attrib['name']
			if name in labels:
				pass
			else:
				labels.append(name)
			mass =specie.text.split(",")[1]

			step_data[name] = float(mass)

		data_array.append(step_data)

if __name__ == "__main__":
	collect_mass_data()

	# Sort based on timestamp of iteration
	data_array = sorted(data_array, key=lambda k: k['timestamp'])

	# also can be done as:
	# from operator import itemgetter
	# data_array = sorted(data_array, key=itemgetter('timestamp'))

	for data in data_array:
		print (data)

	for label in labels:
		print (label)

	with open ("combined.csv", "w", newline='') as csvfile:
		writer = csv.DictWriter(csvfile, fieldnames=labels)

		writer.writeheader()

		for data_step in data_array:
			writer.writerow(data_step)
