# NHS A&E Demand Analysis and Forecasting using Python and Tableau

## Project Overview

This project analyses NHS Accident & Emergency (A&E) attendance data using Python and Tableau.

The aim was to understand how A&E attendances changed over time, identify demand patterns, calculate growth rates, and create a simple 12-month forecast to support healthcare demand planning.

The original NHS Excel file was not analysis-ready. It contained title rows, summary rows, blank rows, unclear headers, and unnecessary columns. Because of this, I had to inspect, clean, transform, analyse, and visualise the data step by step.

This project demonstrates a full healthcare data analytics workflow: from messy Excel data to clean analysis, visual insights, forecasting, and dashboarding.

---

## Business Question

> How have NHS A&E attendances changed over time, and what can recent trends suggest about future demand planning?

---

---

## Dataset Source

The dataset used in this project was obtained from publicly available NHS A&E attendance statistics published by NHS Digital / NHS England.

The data relates to monthly Accident & Emergency attendances and was used for educational and portfolio purposes to practise healthcare data analysis, time-series analysis, and dashboarding.

Source: NHS A&E Attendances and Emergency Admissions statistics.

---

## Data Ethics

This project uses publicly available, aggregated NHS A&E statistics.

No patient-level data, personal information, or identifiable healthcare records were used in this project. The analysis was carried out for learning and portfolio purposes only.

---

## Tools Used

- Python
- pandas
- matplotlib
- Google Colab
- Tableau
- GitHub

---

## Skills Demonstrated

- Data inspection
- Messy Excel data cleaning
- Selecting rows and columns using `iloc`
- Date conversion
- Numeric conversion
- Handling missing values
- Time-series analysis
- Rolling averages
- Month-over-month growth analysis
- Year-over-year growth analysis
- Simple forecasting
- Tableau dashboarding
- Healthcare data storytelling
- Debugging and reflection

---

## Analytics Workflow

Raw NHS Excel File
        ↓
Data Inspection
        ↓
Data Cleaning in Python
        ↓
Trend Analysis
        ↓
Growth Analysis
        ↓
Forecasting
        ↓
Tableau Dashboard
        ↓
Insights and Reflection
```

## Use Case

The intended user of this project could be an NHS analyst, healthcare manager, public health officer, or decision-maker.

The dashboard helps the user to:

view monthly A&E attendance trends
understand long-term demand patterns
identify sudden increases or drops
compare month-over-month and year-over-year growth
review a simple 12-month forecast
support planning discussions




## Methodology
1. Loading the Data
What I did

I loaded the NHS Excel file into Google Colab using pandas.

import pandas as pd

monthly_df = pd.read_excel("Monthly-AE-Time-Series-March-2026-F5ldj2.xls", header=None)
monthly_df.head(20)
How I did it
I used pd.read_excel() to load the Excel file into a pandas DataFrame. I set header=None because the file did not have a clear header row. This let me see the raw structure of the file instead of assuming the first row had useful column names.
Why I did it 
The Excel file had title rows, summary rows, blank rows, and confusing headers before the actual data table. I needed to check the file first before deciding which rows and columns to use. 
What I learned 
That real-world datasets are often messy at the start. Before analyzing anything, I need to understand the structure of the file.


2. Inspecting the Dataset
What I did

I inspected the first rows and columns to find where the real data started.

monthly_df.iloc[0:30, 0:10]
How I did it

I used .iloc[] to view a specific section of the dataset.

0:30 showed the first 30 rows.

0:10 showed the first 10 columns.

Why I did it
I wanted to find the row where the actual monthly data began and identify the columns that had the date and A&E attendance values. 

What I learned 
I learned that if I choose the wrong rows or columns, the chart can appear blank or misleading. This step helped me avoid analysing the wrong part of the file.

3. Selecting Useful Rows and Columns
What I did

After inspecting the file, I selected only the useful rows and columns.

monthly_clean = monthly_df.iloc[15:, [1, 2]]
monthly_clean.columns = ['Date', 'AE']
How I did it

I used iloc to select rows and columns by position.

15: means start from row index 15
[1, 2] means select column index 1 and column index 2

Python starts counting from 0, so column 1 is the second column and column 2 is the third column.

Why I did it

The original file had extra rows and many columns that were not needed for this part of the analysis. I only needed the date and A&E attendance values to start the time-series analysis.

What I learned

I learned that iloc is useful when working with messy Excel reports where the column names are not clear

4. Cleaning the Data
What I did

I cleaned the selected data by converting the Date column into datetime format, converting the A&E attendance column into numeric format, and removing missing values.

monthly_clean['Date'] = pd.to_datetime(monthly_clean['Date'], errors='coerce')
monthly_clean['AE'] = pd.to_numeric(monthly_clean['AE'], errors='coerce')
monthly_clean = monthly_clean.dropna()
How I did it

I used pd.to_datetime() for the Date column and pd.to_numeric() for the A&E attendance column.

I used errors='coerce' so invalid values would become missing values instead of causing the code to fail.

Why I did it

Python needs dates to be recognised as real dates for time-series analysis. It also needs attendance values to be recognised as numbers for calculations such as rolling averages, growth rates, and forecasting.

What I learned

I learned that values can look correct in Excel but still need proper conversion in Python. Data types are important because charts and calculations depend on them.

5. Monthly Trend Analysis
What I did

I created a line chart to show monthly A&E attendances over time.

import matplotlib.pyplot as plt

plt.figure(figsize=(12,6))
plt.plot(monthly_clean['Date'], monthly_clean['AE'], marker='o', label='Monthly A&E')
plt.title("Monthly A&E Attendances Trend")
plt.xlabel("Date")
plt.ylabel("A&E Attendances")
plt.legend()
plt.grid(True)
plt.show()
How I did it

I used matplotlib and plotted Date on the x-axis and A&E attendances on the y-axis.

Why I did it

A line chart is suitable for time-series data because it shows how values change over time.

What I learned

I learned how to use a trend chart to identify long-term movement, peaks, drops, and unusual periods.

6. Rolling Average
What I did

I created a 6-month rolling average.

monthly_clean['Rolling_Avg_6M'] = monthly_clean['AE'].rolling(window=6).mean()
How I did it

Python calculated the average of every 6-month window and moved forward month by month.

Why I did it

Monthly data can be noisy. A rolling average smooths short-term ups and downs and makes the underlying trend easier to see.

What I learned

I learned that raw monthly values show what happened each month, while the rolling average shows the clearer long-term pattern.

7. Month-over-Month Growth
What I did

I calculated month-over-month growth.

monthly_clean['MoM_Growth_%'] = monthly_clean['AE'].pct_change() * 100
How I did it

I used .pct_change() to compare each month with the previous month.

Why I did it

This shows how quickly A&E attendances increased or decreased from one month to the next.

What I learned

I learned that growth analysis shows the speed of change, not just the overall direction.

8. Year-over-Year Growth
What I did

I calculated year-over-year growth.

monthly_clean['YoY_Growth_%'] = monthly_clean['AE'].pct_change(periods=12) * 100
How I did it

I compared each month with the same month in the previous year.

Why I did it

Healthcare data can be seasonal. Comparing the same month across different years gives a fairer comparison.

What I learned

I learned that year-over-year growth is useful when analysing seasonal time-series data.

9. Simple 12-Month Forecast
What I did

I created a simple 12-month forecast using the latest 6-month rolling average.

last_date = pd.to_datetime(monthly_clean['Date'].iloc[-1])
forecast_months = 12

forecast_dates = [
    last_date + pd.DateOffset(months=i)
    for i in range(1, forecast_months + 1)
]

last_avg = monthly_clean['Rolling_Avg_6M'].iloc[-1]
forecast_values = [last_avg] * forecast_months
How I did it

I found the last available date, created 12 future dates, and used the latest rolling average as a simple forecast value.

Why I did it

The forecast gives a basic estimate of future demand. It is not meant to be a perfect prediction, but it shows how recent trends can support planning.

What I learned

I learned that forecasting can be broken down into smaller steps: find the last date, create future dates, estimate values, and plot the result.


## Research and Learning Process

During this project, I researched and revised several concepts while building the analysis.

I focused on understanding:

how to read messy Excel files in pandas
how iloc works for selecting rows and columns
why date columns need datetime conversion
why numeric conversion is needed before calculations
how rolling averages smooth noisy monthly data
how percentage change works for growth analysis
how to create future dates for a simple forecast
how to prepare cleaned data for Tableau

I did not understand every part immediately. For example, the forecasting date code was confusing at first, so I broke it down into smaller steps until I understood the logic and had to google things sometimes or watch youtube tutorials to grasp the concept.

This helped me learn the project properly.

## Difficulties Faced
Messy Excel Structure

The original NHS Excel file was difficult to work with because it included title rows, summary rows, blank rows, and unclear headers.

I had to inspect the file carefully before selecting the correct data.

Wrong Rows and Columns

At first, I selected the wrong rows and columns. This caused my chart to appear blank or incorrect.

I solved this by inspecting more rows and identifying the correct starting row and columns.

Date Problems

The chart did not display properly until the Date column was converted into datetime format.

This helped me understand why correct data types matter in time-series analysis.

Numeric Conversion

The A&E attendance values needed to be converted into numeric format before calculations could work properly.

This showed me that numbers in Excel are not always treated as numbers by Python.

Forecasting Confusion

The forecast code looked complicated at first, especially the part that created future dates.

I broke it down into:

last date
number of months to forecast
future dates
forecast values

After that, the logic became much easier to understand.

## Key Insights
A&E attendances show clear changes over the period analysed.
The 6-month rolling average makes the underlying trend easier to interpret.
A visible disruption appears around 2020, likely linked to the COVID-19 pandemic.
Month-over-month growth highlights short-term spikes and drops.
Year-over-year growth gives a stronger comparison by comparing the same month across different years.
A simple 12-month forecast can support early planning discussions.
The project shows how messy healthcare data can be transformed into useful operational insight.

## Reflection

This project helped me understand that data analysis is not just about writing code or creating charts.

The most important parts are:

understanding the problem
inspecting the data
cleaning it correctly
checking mistakes
choosing useful metrics
explaining the results clearly

I made mistakes during the project, especially with selecting the wrong rows and columns at first. Fixing those mistakes helped me understand the data better.

This project taught me that debugging is part of real data analysis. A blank or incorrect chart is not failure. It is a signal to inspect the data again and find the issue.

## Future Improvements

In the future, I would like to improve this project by:

adding SQL analysis
comparing forecasting models such as ARIMA or Prophet
adding confidence intervals to the forecast
including hospital-level or regional breakdowns
comparing A&E attendances with emergency admissions
analysing waiting-time performance
adding more Tableau filters
automating the cleaning process


