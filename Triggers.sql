-- TRIGGERS
DELIMITER //
CREATE TRIGGER atualiza_status_veiculo_alugado
AFTER INSERT ON locacoes
FOR EACH ROW
BEGIN
  UPDATE veiculos SET disponibilidade = 'alugado' WHERE id_veiculo = NEW.id_veiculo;
END //

DELIMITER //
CREATE TRIGGER atualiza_status_veiculo_disponivel
AFTER UPDATE ON locacoes
FOR EACH ROW
BEGIN
    UPDATE veiculos SET disponibilidade = 'disponível' WHERE id_veiculo = OLD.id_veiculo AND OLD.data_entrega <=NOW();
END // DELIMITER ;

-- INSERT INTO locacoes (id_cliente, id_veiculo, data_locacao, valor_total) VALUES 
--    (1, 1, '2023-04-19', 500.00); 
    
    
    
DELIMITER //
CREATE TRIGGER calcao_automatico
AFTER INSERT ON locacoes
FOR EACH ROW
BEGIN
	INSERT INTO pagamento (id_locacao, id_funcionario, tipo_multa, data, valor, status_pagamento) VALUES
    (NEW.id_locacao, 1, 'Calção', NOW(), '1000.00', 'pago');
END // DELIMITER ;

-- INSERT INTO locacoes (id_cliente, id_veiculo, data_locacao, valor_total, data_entrega, quilometros_rodados) VALUES 
--    (1, 15, '2023-04-10', 500.00, '2023-04-20', 300),