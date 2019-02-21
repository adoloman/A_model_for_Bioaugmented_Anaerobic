# Author : Yehor Pererva

import os, sys
import xml.etree.ElementTree as ET

BASE_DIR = os.path.dirname(os.path.realpath(__file__))

filename = r'env_State(1020).xml'

pixel_volume = 64 * pow (10, -15)
columns = 127

if __name__ == "__main__":
	tree = ET.parse(os.path.join (BASE_DIR, filename))
	root = tree.getroot()

	for solute in root.iter('solute'):
		name = solute.attrib['name']
		# need to split by lines, but it generates array fo strings with ";" in the end
		# also, sometimes '' values occures
		data = solute.text.splitlines()
		# get rid of ";" and ''
		data = [ float (item.strip(';')) for item in data if item != '']
		tmp = sum(data)
		print ('{name} :\n\tMass :\t{biomass} \n\tAverage concentration :\t{concentration}'.format(
			name=name,
			biomass = tmp * pixel_volume,
			concentration = tmp / columns**2
			))
