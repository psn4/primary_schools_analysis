# primary_schools_analysis

This script will load the last few years of key stage 2 data and make it relatively easy to analyse using SQL

## usage

 * Install [KDB](https://kx.com/download/) and if needed a GUI ( [studio](https://github.com/CharlesSkelton/studio) [qpad](http://www.qinsightpad.com/download.html))
 * Clone the project
 * Launch the script (open a port if connecting via a GUI)
```
    q parse_ks2.q -p 1250
```
 * Run whatever analysis you want to do via a GUI or on the console

## sample queries
This will really depend on what you are looking to do but some examples

```
select from ks2 where postCode like "SL6*"  / see schools in a post code area

`urn`year xdesc select from ks2 where urn  in 138173 102316 / check 2 specific schools

select distinct schoolName,count i  by urn from ks2 where postCode = `$"WV4 5LG" / note the urn is a bit iffy, postcode seems more reliable

`total_score xcols `total_score xdesc update  total_score:(1.2*reading_high_perc)+(1.5*writing_high_perc)+(0.5*maths_high_perc) from select from ks2 where year = 2018 / weight it by whatever you value

`avg_score_reading xdesc select from ks2 where year = 2018 / only available since 2016

select from (`avg_score_weighted_last_3_years xdesc  select avg_score_weighted_last_3_years:{x:-4#x;c:count x;(til c) wavg x}avg_score_maths,avg_score_maths,ema_maths_perc_high:{ema[1%3;`float$reverse fills reverse x]}maths_high_perc,maths_high_perc,last_year_high_maths_perc:last maths_high_perc,avg_high_maths_perc:avg maths_high_perc,lastAvailableMathsData:last year,observations:count i by schoolName,town,postCode from ks2 where not null maths_high_perc) where observations > 4, lastAvailableMathsData= 2018 
```
## data

 * Data is from the [govt website](https://www.compare-school-performance.service.gov.uk/download-data?currentstep=datatypes&regiontype=all&la=0&downloadYear=2017-2018&datatypes=ks2). It gives a nice front end but not as much detail or power.
 * May need some cleaning. Some data is missing
 * You can download new data or older years and modify the script to load it. But it may need some massaging as it can change
 * Meta data file is available on the website to understand the raw headings, ks2revised_meta.csv
 * col names
    * rwm = reading writing maths
    * gps = grammar punctuation spelling

## improvements
Submit a PR or raise an issue
