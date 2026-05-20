import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import numpy as pd

df = pd.read_csv("finanAgroGoias2014.csv", encoding='utf-8', sep= ';')
df.head()

#troca todos os '-' por zero
df = df.replace('-', '0')
df.head(10)

#verificar o tipo de dado das colunas
df.dtypes