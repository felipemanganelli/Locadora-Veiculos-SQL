-- FUNCTIONS
DELIMITER //
DELIMITER //
CREATE FUNCTION cnh_vencida (id_pessoa INT) RETURNS VARCHAR(10)
BEGIN
    DECLARE validade DATE;
    SELECT data_validade_cnh INTO validade
    FROM clientes
    WHERE id_pessoa = id_cliente
    LIMIT 1;
    IF validade < CURRENT_DATE() THEN
        RETURN 'Vencida';
    ELSE
        RETURN 'Válida';
    END IF;
END //
DELIMITER ;

-- SELECT cnh_vencida(1);



DELIMITER //
CREATE FUNCTION passar_multa(id INT) RETURNS VARCHAR(100)
BEGIN
    DECLARE status VARCHAR(100);
    SELECT status_multa INTO status
    FROM multas_transito
    WHERE id_multa = id;
    IF status = 'passada para condutor' THEN
        RETURN 'Já havia sido passada';
    ELSE
		UPDATE multas_transito SET status_multa = 'passada para condutor' WHERE id_multa = id;
        RETURN 'Concluído';
    END IF;
END //
DELIMITER ;

-- SELECT passar_multa(2);