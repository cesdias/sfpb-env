-- change database and user
\connect datalake datalakeuser


-- Cria VIEW com as datas de emissão mais recentes para as tabelas: FatoNFe, FatoCTe, FatoMDFe, FatoEventoMDFe, FatoEventoCTe
CREATE VIEW app.latest_dfe_dhemi_view AS 
	SELECT *
	FROM (
			(SELECT MAX("infnfe_ide_dhemi") as nfe FROM app.fatonfe where infnfe_ide_mod = 55) as dhnfe 
			NATURAL FULL OUTER JOIN
			(SELECT MAX("infnfe_ide_dhemi") as nfce FROM app.fatonfe where infnfe_ide_mod = 65) as dhnfce 
			NATURAL FULL OUTER JOIN 
			(SELECT MAX("infcte_ide_dhemi") as cte FROM app.fatocte) as dhcte
			NATURAL FULL OUTER JOIN
			(SELECT MAX("infmdfe_ide_dhemi") as mdfe FROM app.fatomdfe) as dhmdfe
			NATURAL FULL OUTER JOIN
			(SELECT MAX("eventomdfe_infevento_dhevento") as eventomdfe FROM app.fatoeventomdfe) as dheventomdfe
			NATURAL FULL OUTER JOIN
			(SELECT MAX("eventocte_infevento_dhevento") as eventocte FROM app.fatoeventocte) as dheventocte
			NATURAL FULL OUTER JOIN
	 		(SELECT CURRENT_DATE as dsync) as datesync
		) as temp;

