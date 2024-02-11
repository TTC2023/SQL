-- Check for Null values 
SELECT
  COUNT(*) AS total_rows,
  COUNT(symbol) AS symbol_not_null,
  COUNT(date) AS date_not_null,
  COUNT(open) AS open_not_null,
  COUNT(high) AS high_not_null,
  COUNT(low) AS low_not_null,
  COUNT(close) AS close_not_null,
  COUNT(volume) AS volume_not_null
FROM
  sp_500.stock_data sd;

-- Make sure date is all in the same format 
UPDATE sp_500.stock_data
SET date = STR_TO_DATE(date, '%M %d %Y')
WHERE STR_TO_DATE(date, '%M %d %Y') IS NOT NULL;

-- Which date in the sample saw the largest overall trading volume? March, 11, 2015 had the highest trading volume at 24,403,174.
-- On that date, which two stocks were traded most? INCY and APA were the most traded stocks on this day.
SELECT date, MAX(volume) as most_volume
FROM stock_data
GROUP BY date
ORDER BY most_volume
LIMIT 1;

SELECT date, symbol, volume 
FROM stock_data
WHERE date = '2015-03-11'
ORDER BY volume DESC
LIMIT 2;

-- On which day of the week does volume tend to be highest? Monday Lowest? Friday
SELECT DAYOFWEEK(STR_TO_DATE(date, '%W, %M %d, %Y')) AS day_of_week, 
       SUM(volume) AS total_volume
FROM stock_data
GROUP BY day_of_week
ORDER BY total_volume DESC
LIMIT 1;

-- On which date did Amazon (AMZN) see the most volatility, measured by the difference between the high and low price? Friday, July 24, 2015 with 51.22 points.
SELECT date, ROUND(SUM(high-low),2) AS volatility
FROM stock_data
WHERE symbol = 'AMZN'
GROUP BY date
ORDER BY volatility DESC
LIMIT 1;

-- If you could go back in time and invest in one stock from 1/2/2014 - 12/29/2017, which would you choose? What % gain would you realize?
 



