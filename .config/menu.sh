#!/bin/bash
opcao=$( dialog						\
	--stdout					\
	--backtitle "ROKUKISHI PROJECT"			\
	--ok-label Selecionar				\
	--cancel-label Sair				\
	--title "Menu"					\
	--menu "Escolha um gerenciador:" 		\
	0 0 0						\
	1 "Gerenciador de Arquivos"			\
	2 "Gerenciador de Usuários"			\
	3 "Gerenciador de Redes"			\
	4 "Gerenciador de Dispositivos"			\
	5 "Gerenciador de Pacotes" 			\
	6 "Créditos e agradecimentos" )
case $opcao in
	1) bash /Projeto/.config/gerenciadordearquivos/garq.sh;;
	2) bash /Projeto/.config/gerenciadordeusuarios/gusr.sh;;
	3) bash /Projeto/.config/gerenciadorderedes/gred.sh;;
	4) bash /Projeto/.config/gerenciadordedispositivos/gdis.sh;;
	5) bash /Projeto/.config/gerenciadordepacotes/grep.sh;;
	6) bash /Projeto/.config/creditos/creditos.sh;;
	*) exit;;
esac
# Temos aqui o menu completo, onde se pede que o usuário escolha um dos gereciadores disponiveis
# Chamando assim o script de seu gerenciador
# Caso aperte Cancel, ESC ou qualquer outra coisa, o programa será encerrado com retorno 0

