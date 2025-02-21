#!/usr/bin/python
#Lrlrlr 120319 rmsdVSscore_plot.python
#Usage: to plot rms_core to score from input models.table
#
#Library and dataset
import seaborn as sns; sns.set()
import matplotlib.pyplot as plt

df = sns.load_dataset("models.table")

ax= sns.scatterplot(x="rms_core", y="scores")

#Use regplot function to make a scatterplot
sns.regplot(x=df["rms_core"], y=df["score"])
#sns.plt.show()
