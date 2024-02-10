-- What percentage of games were won by white? 49.86% How many ended in a draw? 4.74%

SELECT
    ROUND(
    (SUM(CASE WHEN winner = 'White' THEN 1 ELSE 0 END) 
    / COUNT(winner) * 100),2) 
    AS percentage_won_by_white
FROM chess_games_schema.chess_data;

SELECT 
	ROUND(
    (SUM(CASE WHEN winner = 'Draw' THEN 1 ELSE 0 END)
    / COUNT(winner) * 100),2)
    AS percentage_draws
FROM chess_games_schema.chess_data;

-- Which opening move was most frequently used in games in which black won? Zukertort Opening
-- What about when white won? It is still the Zukertort Opening

SELECT MAX(opening_shortname) as most_opening
FROM chess_games_schema.chess_data;

SELECT MAX(opening_shortname) as most_opening
FROM (SELECT * 
		FROM chess_games_schema.chess_data
		WHERE winner = 'White') as white_table;
        
-- What percentage of games are won by the player with the higher rating? 61.58%
-- Does this vary by piece color? White has a 3 percent more chance of winning then black.

SELECT ROUND((SUM(CASE 
				WHEN white_rating > black_rating AND winner = 'White' THEN 1
				WHEN black_rating > white_rating AND winner = 'Black' THEN 1 
                ELSE 0
			END) / COUNT(winner)*100),2) AS higher_rank_wins
FROM chess_games_schema.chess_data;

SELECT ROUND((SUM(CASE 
				WHEN white_rating > black_rating AND winner = 'White' THEN 1
				WHEN black_rating > white_rating AND winner = 'Black' THEN 1
                ELSE 0
			END) / COUNT(winner)*100),2) AS higher_rank_wins
FROM chess_games_schema.chess_data;

-- Which user won the most amount of games? User taranga won the most amount of games with 72 wins.
-- In what percentage of those games was the user the higher rated player? He was the higher ranked player in 50% of those games. 

SELECT player_id, COUNT(*) AS total_wins
FROM (
    SELECT CASE WHEN winner = 'Black' THEN black_id ELSE white_id END AS player_id
    FROM chess_games_schema.chess_data
    WHERE winner IN ('Black', 'White')
) AS wins
GROUP BY player_id
ORDER BY total_wins DESC
LIMIT 1;

SELECT player_id, 
       COUNT(*) AS total_wins,
       SUM(CASE 
             WHEN (player_id = black_id AND black_rating > white_rating) OR 
                  (player_id = white_id AND white_rating > black_rating) THEN 1
             ELSE 0
           END) / 72 AS higher_rank_percent
FROM (
    SELECT CASE WHEN winner = 'Black' THEN black_id ELSE white_id END AS player_id,
           black_id,
           white_id,
           black_rating, -- Assuming this column exists
           white_rating  -- Assuming this column exists
    FROM chess_games_schema.chess_data
    WHERE winner IN ('Black', 'White')
) AS wins
GROUP BY player_id
ORDER BY total_wins DESC
LIMIT 1;


        

        
		