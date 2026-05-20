INSERT INTO "SELECT 
    ""Tipo_Patogeno"",
    AVG(""Porcentagem_Disseminacao"") AS Media_Disseminacao,
    SUM(""Mortes_Estimadas"") AS Total_Mortes
FROM pandemic_world
GROUP BY ""Tipo_Patogeno""
ORDER BY Total_Mortes DESC" ("Tipo_Patogeno",media_disseminacao,total_mortes) VALUES
	 ('Virus',4.893296163547068,163453270),
	 ('Bacteria',8.15345452857119,122028939),
	 ('Unknown',8.334999978542328,550000);
