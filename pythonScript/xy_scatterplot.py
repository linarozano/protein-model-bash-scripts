#!/usr/bin/python
#need to convert all table to csv
#cp *.table *.csv
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
import pandas as pd

df = pd.read_csv('541_m.csv', index_col=0)  #load file
df.head() #How it looks like

sns.lmplot(x='rms_core', y='score', data=df, 
    fit_reg=False) #remove regression line

#Tweak axis limit and title using matplotlib
plt.ylim(-500, None)
plt.xlim(0, None)
plt.title('rms_core vs score plot')


sns.kdeplot(df.rms_core, df.score) #density plot
plt.savefig('xy_scatter.png')

sns.jointplot(x='rms_core', y='score', data=df) #joint distribution plots


