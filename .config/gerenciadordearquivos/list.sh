#!/bin/bash
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--menu "Como deseja listar?"	 		\
	0 0 0						\
	1 "Mostrar apenas o conteúdo"			\
	2 "Mostrar tamanho em KBytes"			\
	3 "Mostrar arquivos ocultos"			\
	4 "Mostrar permissões/grupos/donos/modificações"\
	5 "Voltar" )
case $opcao in
	1) list1 ;;
	2) list2 ;;
	3) list3 ;;
	4) list4 ;;
	5) bash /Projeto/.config/gerenciadordearquivos/garq.sh ;;
	*) bash /Projeto/.config/gerenciadordearquivos/garq.sh ;;
esac
# Opções que permite o usuário escolher entre 4 listagens diferentes com suas respectivas caracteristicas mencionadas
# Ao pressionar qualquer outra coisa q não seja uma das opções, voltará para o script gerenciador de arquivos
}
function list1(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório (sem espaço, caso seja preciso, utilize aspas no nome do diretório):"	\
	10 60 )
case $? in
	1|255) menu;;
esac
# Pedirá para o usuário digitar o nome do diretório a ser listado
ls $arq > /tmp/listar.txt
# Será listados apenas os nomes dos arquivos e diretórios não ocultos no diretório escolhido pelo usuário
# Mandando a listagem para um arquivo temporário
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0 Mostrará a lista via dialog
# Caso seja 2 o diretório é inexistente
# Caso o retorno seja desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function list2(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório (sem espaço, caso seja preciso, utilize aspas no nome do diretório):"	\
	10 60 )
case $? in
	1|255) menu;;
esac
# Pedirá para o usuário digitar o nome do diretório a ser listado
ls -la $arq > /tmp/listar.txt
# Será listados os nomes dos arquivos e diretórios não ocultos e seu tamanho em Kbytesno no diretório escolhido pelo usuário
# Mandando a listagem para um arquivo temporário
case $? in
	0) dialog	 					\
		--title "Listagem"				\
 		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0 Mostrará a lista via dialog
# Caso seja 2 o diretório é inexistente
# Caso o retorno seja desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function list3(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório (sem espaço, caso seja preciso, utilize aspas no nome do diretório):"	\
	10 60 )
case $? in
	1|255) menu;;
esac
# Pedirá para o usuário digitar o nome do diretório a ser listado
ls -a $arq > /tmp/listar.txt
# Será listados apenas os nomes dos arquivos e diretórios ocultos no diretório escolhido pelo usuário
# Mandando a listagem para um arquivo temporário
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0 Mostrará a lista via dialog
# Caso seja 2 o diretório é inexistente
# Caso o retorno seja desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function list4(){
arq=$( dialog						\
	--stdout					\
	--title "Listar Diretório"			\
	--inputbox "Digite o nome/local do diretório (sem espaço, caso seja preciso, utilize aspas no nome do diretório):"	\
	10 60 )
case $? in
	1|255) menu;;
esac
# Pedirá para o usuário digitar o nome do diretório a ser listado
ls -lah $arq > /tmp/listar.txt
# Será listados os nomes, permissões, dono, grupo, modificação, tamanho e criação dos arquivos e diretórios no diretório escolhido pelo usuário
# Mandando a listagem para um arquivo temporário
case $? in
	0) dialog	 					\
		--title "Listagem"				\
		--textbox /tmp/listar.txt 0 0; menu;;
	2) dialog						\
		--msgbox "Diretório não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0 Mostrará a lista via dialog
# Caso seja 2 o diretório é inexistente
# Caso o retorno seja desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
menu
