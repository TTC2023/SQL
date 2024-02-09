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
-- Does this vary by piece color?

SELECT ROUND((SUM(CASE 
				WHEN white_rating > black_rating AND winner = 'White' THEN 1
				WHEN black_rating > white_rating AND winner = 'Black' THEN 1 
                ELSE 0
			END) / COUNT(winner)*100),2) AS higher_rank_wins
FROM chess_games_schema.chess_data;

		