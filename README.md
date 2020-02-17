<h1 align="center"> Data Science Projects Portfolio - Peyman Kor </h1> <br>
<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio">
    <img alt="DataScience" title="DataScience" src="https://images.squarespace-cdn.com/content/v1/54ad9bf4e4b0618d6af9be81/1480280105298-I38TK9AYARZ4I2APOH49/ke17ZwdGBToddI8pDm48kNij0lEt8mkm0VuEfDKf7TNZw-zPPgdn4jUwVcJE1ZvWEtT5uBSRWt4vQZAgTJucoTqqXjS3CfNDSuuf31e0tVEK6nv0N7bd92DrnsqQifa7MgxkYh9Pu-eQN_dRuLo0shur-lC0WofN0YB1wFg-ZW0/word+cloud.png?format=500w" width="800" height="400">
  </a>
</p>


## Welcome!

![image](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/cover.jpg)

## Table of Contents
- [Introduction](#introduction)

- [Customer Data Processing](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/costumer_database/Customer_Database.ipynb)
- [DataBase Management for Costumer Purchases](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/DataBase/DataBase.ipynb)
- [Coronavirus Analysis](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Crono_Virus/crona_rmk.md)
- [Probabilistic Modeling](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Crono_Virus/crona_rmk.md)
- [General Linear Model (GLM) for Atmospheric CO2](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Least%20Square%20Trend%20Modeling/Project%231.Rmd)
- [ARIMA model atmospheric CO2](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Seasonal%20ARIMA%20Modeling/medium_post.md)
- [Kalman Filter](https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Time%20Series%20Analysis/Project%20%23%204)
- [The UN Refugee Council Project](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/UNHCR%20Report/Report.md)
- [New York City Bike Trips](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/New_York_City_Bike_Trips/unacastanalysis.md)
- [Bayesian Neural Network](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/BNN-Project/Deep_Learning_Project.pdf)
- [Leaf Classification](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Pytorch/6.1-EXE-Kaggle-Leaf-Challenge.ipynb)
- [XGBoost Statistical Model](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/XGBOOST_Machine_Learning/xgboost.md)
- [Amazon Web Service (S3 and Retrieval](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/XGBOOST_Machine_Learning/xgboost.md)
- [Google Cloud Platform](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/XGBOOST_Machine_Learning/xgboost.md)
- [Racing Bar Plot](https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Racing_Bar_Plot/NPDdata_anim_22_1.gif)

## Introduction
[![Awesome](https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg)](https://github.com/KevinLiao159/MyDataSciencePortfolio)
![Python](https://img.shields.io/badge/python-v3.6+-blue.svg)
![Dependencies](https://img.shields.io/badge/dependencies-up%20to%20date-brightgreen.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Welcome to my awesome data science project portfolio. In my repo, you can find awesome and practical solutions to some of the real world business problems with statistical methods and the-state-of-art machine learning models. Most of my projects will be demoed in jupyter notebook or in Rmarkdown. Jupyter notebook and R markdown are great tools for communication purposes. For each project, I will provide summary of the project and a picture shows the highlight of the analysis.

My project collection covers various Data Science and Machine Learning applications such as *Deep Learning*, *Data Cleaning, Processing and Visulization*, and *Dashboarding*. There are more to come. I will try my best to bing my curreny projects here so that it could provide the comprehensive hands-on practices for interested people in data analytics community.

## Customer Data Processing


<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/costumer_database/Customer_Database.ipynb">
    <img alt="Customer Database Analysis" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/costumer_database/project1_1.png">
  </a>
</p>

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/costumer_database/Customer_Database.ipynb">
    <img alt="Customer Database Analysis" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/costumer_database/project1_2.png">
  </a>
</p>
This project consist the dataset of transaction of the costumer for the corporation over the years. The data table consist of the date of transaction, the company of costumer, the city, country of the costumer. The data includes around 20000 transaction of the corportaion with six columns. The objective of this project is:

+ Cleaning and Processing the Data to the Clean Data
+ Enriching the Columns for Better Analysis
+ Building the SQL DataBase

## General Linear Model (GLM) for Atmospheric CO2
<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Least%20Square%20Trend%20Modeling">
    <img alt="Medium Blogpost" title="Medium Blogpost" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Least%20Square%20Trend%20Modeling/plot.png">
  </a>
</p>

This project to make model for Co2 concentration of Co2 from 1960-2019. Here, at this stage focused was made on the General linear Model to model the data. The harmonic linear model was used to model both increasing trend as well to take care of the seasonality of the data. Both the oridnary Least Sqaure and as well Weighted Least Square was used during the modeling process.

## Database Management for Costumer Purchases

In this work a database is maed, the data is inserted into the datatables and the qurying the tables are shown. The sqlite3 library is used for working with database. The following steps rae taken to conduct this projects:
+ Data in dataframe fromat is imported
+ Connection with datatable is made and then two seperat tables known as clients and transactin tables are created.
+ Client and Transaction data are inserted to the tables.
+ Desired query is performed for example, total sale per company.

## Seasonal ARIMA modeling for Atmospheric CO2
<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Seasonal%20ARIMA%20Modeling/medium_post.md">
    <img alt="Medium Blogpost" title="Medium Blogpost" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Seasonal%20ARIMA%20Modeling/medium_post_files/figure-markdown_strict/unnamed-chunk-10-1.png">
  </a>
</p>

This project go through the Time Series Modeling for historical CO2 Concentration (1958–2019) in R. The Seasonal ARIMA modeling is used to build the model. Knowing that it has often been stated that the CO2 concentration should be attained below 460 ppm before the start of the second half of this century, specifically, this post seeks to answer this question:
 + If the current trend in Co2 Concentration continues (Business as usual) what is the chance to reach 460 ppm at the beginning of the second half of the century?

## UNHCR Report

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/UNHCR%20Report/Report.md">
    <img alt="Customer Database Analysis" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/UNHCR%20Report/Report_files/figure-markdown_strict/unnamed-chunk-17-1.png">
  </a>
</p>

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/UNHCR%20Report/Report.md">
    <img alt="Customer Database Analysis" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/UNHCR%20Report/Report_files/figure-markdown_strict/unnamed-chunk-8-1.png">
  </a>
</p>

In this work the data of United Refugee Agency is used to analysie the afghan refueeges and asylum seekers over last 40 years and specifically, given the data, the report tries to answer the following questions:

+ Which countries host the most Afghan refugees and asylum seekers? Create a plot of the Top 10 and a plot of the Top 5 countries with the biggest increase from 2017 to 2018. Where did you find the data and how did you decide to visualize it?

+ Is there a relationship between the number of Afghan refugees and asylum seekers in a country and the distance between that country and Afghanistan?

+ Visualize for the last 10 years: total number of refugees and asylum seekers from Afghanistan together with the number of internally displaced from Afghanistan.


## New York City Bike Trip Analysis

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/New_York_City_Bike_Trips/unacastanalysis.md">
    <img alt="Customer Database Analysis" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/New_York_City_Bike_Trips/unacastanalysis_files/figure-markdown_strict/unnamed-chunk-18-1.png">
  </a>
</p>

This project revolves around doing some analysis of the NYC City Bike dataset. The data could be accessed from thr: [https://console.cloud.google.com/marketplace/details/city-of-new-york/nyc-citi-bike]

Using the Google Platform Cloud the following questions are answered:

+ What is the trip duration distribution of Citibike trips?
+ What is the most popular Citibike trip?
+ Were there new bike stations introduced or removed at any point in time? What makes you think it were or weren't?



## CORONA VIRUS ANLYSIS

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysis1" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Crono_Virus/crona_rmk_files/figure-markdown_strict/unnamed-chunk-18-1.png">
  </a>
</p>

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysi2s" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Crono_Virus/crona_rmk_files/figure-markdown_strict/unnamed-chunk-9-1.png">
  </a>
</p>
Churn rate is one of the important business metrics. A company can compare its churn and growth rates to determine if there was overall growth or loss. When the churn rate is higher than the growth rate, the company has experienced a loss in its customer base.

Why customers churn and stop using a company's services? What is the estimate amount of churn for next quarter? Being able to answer above two questions can provide meaningful insights about what direction the company is currently heading towards and how the company can improve its products and services so that constomers would stay. 

## Bayesian Neural Network

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/BNN-Project">
    <img alt="Customer Database Analysis" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/BNN-Project/bayesianup.png">
  </a>
</p>

Churn rate is one of the important business metrics. A company can compare its churn and growth rates to determine if there was overall growth or loss. When the churn rate is higher than the growth rate, the company has experienced a loss in its customer base.

Why customers churn and stop using a company's services? What is the estimate amount of churn for next quarter? Being able to answer above two questions can provide meaningful insights about what direction the company is currently heading towards and how the company can improve its products and services so that constomers would stay. 


## Deep Learning Projcet(Leaf Classification) 

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysis1" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Pytorch/leaf1.png">
  </a>
</p>

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysi2s" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Pytorch/leaf2.png">
  </a>
</p>
Churn rate is one of the important business metrics. A company can compare its churn and growth rates to determine if there was overall growth or loss. When the churn rate is higher than the growth rate, the company has experienced a loss in its customer base.

Why customers churn and stop using a company's services? What is the estimate amount of churn for next quarter? Being able to answer above two questions can provide meaningful insights about what direction the company is currently heading towards and how the company can improve its products and services so that constomers would stay. 



## Machine Learning Model(XGBoost) 

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysis1" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/XGBOOST_Machine_Learning/xgboost_files/figure-markdown_strict/unnamed-chunk-5-1.png">
  </a>
</p>

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysi2s" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/XGBOOST_Machine_Learning/xgboost_files/figure-markdown_strict/unnamed-chunk-13-1.png">
  </a>
</p>
Churn rate is one of the important business metrics. A company can compare its churn and growth rates to determine if there was overall growth or loss. When the churn rate is higher than the growth rate, the company has experienced a loss in its customer base.

Why customers churn and stop using a company's services? What is the estimate amount of churn for next quarter? Being able to answer above two questions can provide meaningful insights about what direction the company is currently heading towards and how the company can improve its products and services so that constomers would stay. 

## Amazoon Web Service Project

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Crono%20Virus">
    <img alt="Customer Database Analysis1" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/AWS_Project/dashboard_demo_gif.gif">
  </a>
</p>

Churn rate is one of the important business metrics. A company can compare its churn and growth rates to determine if there was overall growth or loss. When the churn rate is higher than the growth rate, the company has experienced a loss in its customer base.

Why customers churn and stop using a company's services? What is the estimate amount of churn for next quarter? Being able to answer above two questions can provide meaningful insights about what direction the company is currently heading towards and how the company can improve its products and services so that constomers would stay. 


## Racing Bar Plot

<p align="center">
  <a href="https://github.com/Peymankor/Data-Science_Portfolio/tree/master/Racing_Bar_Plot">
    <img alt="Customer Database Analysis1" title="Customer Database Analysis" src="https://github.com/Peymankor/Data-Science_Portfolio/blob/master/Racing_Bar_Plot/NPDdata_anim_22_1.gif">
  </a>
</p>

Churn rate is one of the important business metrics. A company can compare its churn and growth rates to determine if there was overall growth or loss. When the churn rate is higher than the growth rate, the company has experienced a loss in its customer base.

Why customers churn and stop using a company's services? What is the estimate amount of churn for next quarter? Being able to answer above two questions can provide meaningful insights about what direction the company is currently heading towards and how the company can improve its products and services so that constomers would stay. 

