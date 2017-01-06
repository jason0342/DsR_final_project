#!/usr/bin/env python

from sklearn import preprocessing
from sklearn.svm import SVR
import os.path
import numpy as np
import random
#from AE import AE

kernel = 'rbf'
C = 1.1
epsilon = 0.5

def main():
	# read file
	features = []
	targets = []
	with open('MLdata.csv', 'r') as f:
		f.readline()
		for line in f:
			line = line.strip().split(',')
			line = [float(item) for item in line[2:]]
			features.append(line[1:3])
			targets.append(line[0])
	
	test16 = []
	groundtruth = []
	with open('data2016.csv', 'r') as f:
		f.readline()
		for line in f:
			line = line.strip().split(',')
			groundtruth.append(float(line[1]))
			line = line[4:6]
			line = [float(item) for item in line]
			test16.append(line)
	test16 = preprocessing.scale(np.array(test16)).tolist()

	#train_ae = np.array(features+test16)
	features = np.array(features)
	targets = np.array(targets)

	std = targets.std(axis=0)
	mean = targets.mean(axis=0)

	features = preprocessing.scale(features)
	targets = preprocessing.scale(targets)

	l = features.shape[1]

	# autoencoder
	"""
	ae = AE([l, 6])
	if os.path.isfile('./model.h5')	:
		ae.load('./model.h5')
	else:
		ae.training(train_ae, 5, verbose=1)
		ae.save('./model.h5')
	#features = ae.encode(features)
	"""
	"""
	idx = range(features.shape[0])
	random.shuffle(idx)	
	trlabel = int(features.shape[0]*0.8)

	Xtr = features[idx[:trlabel]]
	Ytr = targets[idx[:trlabel]]
	Xte = features[idx[trlabel:]]
	Yte = targets[idx[trlabel:]]
	"""

	reg = SVR(kernel=kernel, C=C, epsilon=epsilon)
	#reg.fit(Xtr, Ytr)
	reg.fit(features, targets)
	"""
	pred = reg.predict(Xte)
	pred = pred * std + mean;
	Yte = Yte * std + mean;

	error = 0
	for i in range(Xte.shape[0]):
		error += (Yte[i]-pred[i])**2
		print Yte[i], pred[i]
	error /= Xte.shape[0]
	print error**0.5
	"""
	"""
	test16 = []
	groundtruth = []
	with open('data2016.csv', 'r') as f:
		f.readline()
		for line in f:
			line = line.strip().split(',')
			groundtruth.append(float(line[1]))
			line = line[4:]
			line = [float(item) for item in line]
			test16.append(line)
	"""
	
	test16 = np.array(test16)
	test16 = preprocessing.scale(test16)

	#test16 = ae.encode(test16)
	predict = reg.predict(test16)
	predict = predict * std + mean
	
	print
	print "2016 movies prediction:"
	err = 0.
	
	for i in range(predict.shape[0]):
		print predict[i], groundtruth[i]
		err += (predict[i]-groundtruth[i])**2
	err /= predict.shape[0]
	err = err**0.5
	
	
	with open('result.csv', 'w') as f:
		for i in range(predict.shape[0]):
			f.write('%.5f,%.5f\n' % (predict[i], groundtruth[i]))

	print err

if __name__ == '__main__':
	main()
