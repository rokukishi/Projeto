#/bin/bash
# Criar um usuário dentro de um grupo
function MENU(){
OPCAO=$( dialog						\
	--stdout					\
	--backtitle "ROKUKISHI PROJECT"			\
	--ok-label Selecionar				\
	--cancel-label Voltar				\
	--menu "Escolha uma das opções"			\
	0 0 0						\
	1 "Criar usuário"				\
	2 "apagar usuário"				\
	3 "Criar grupo"					\
	4 "apagar grupo"				\
	5 "Criar ou alterar Senha"			\
	6 "Adicionar usuário a um grupo"        		\
	7 "Criar um usuário dentro de um grupo"		\
	8 "Mostrar usuários"				\
	9 "Mostrar grupos" )
case $OPCAO in
 	1) CUSR ;;
	2) AUSR ;;
	3) CGRP ;;
	4) AGRP ;;
	5) APAS	;;
	6) AUGR ;;
	7) CUSG ;;
	8) MUSR ;;
	9) MGRP ;;
	*) bash /Projeto/.config/menu.sh	;;
esac
}
CUSR(){
	NOME=$(	dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Nome do usuário" 0 0)
	case $? in
		1|255) MENU;;
	esac
	useradd -m -s /bin/rokukishii $NOME
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME criado com sucesso!" 0 0;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Tente novamente!" 0 0; CUSR;;
	9) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME já existe" 0 0; MENU;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; MENU;;
esac
dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --yesno "É necessário criar uma senha para esse usuário para poder usá-lo. Deseja fazer isso agora?" 0 0
v=$?
passw
}
function passw(){
case $v in
	0) passwd $NOME; volta=$?;;
	1) MENU;;
	*) MENU;;
esac
case $volta in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Senha criada com sucesso" 0 0; MENU;;
 	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Senha inválida, ou não são iguais"	\
	 0 0; dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --yesno "Tentar novamente?" 0 0; n=$?;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel criar"		\
	 0 0; dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --yesno "Tentar novamente?" 0 0; n=$?;;
esac
case $n in
	0) passw;;
	1) MENU;;
	*) MENU;;
esac
}
AUSR(){
	NOME=$(	dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Nome do usuário" 0 0 )
	case $? in
		1|255) MENU;;
	esac
	userdel -f $NOME
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME apagado com sucesso!" 0 0; MENU;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Tente novamente!" 0 0; AUSR;;
	6) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME não existe" 0 0; MENU;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; MENU;;
esac
}
CGRP(){
	NOME=$(	dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Nome do grupo" 0 0 )
	case $? in
		1|255) MENU;;
	esac
	groupadd $NOME
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Grupo $NOME criado com sucesso!" 0 0; MENU;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Tente novamente!" 0 0; CUSR;;
	9) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Grupo $NOME já existe" 0 0; MENU;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; MENU;;
esac
}
AGRP(){
	NOME=$(	dialog --stdout 				\
		--backtitle "ROKUKISHI PROJECT"			\
		 --ok-label Continuar 				\
		--cancel-label Voltar				\
		--inputbox "Nome do grupo" 0 0 )
	case $? in
		1|255) MENU;;
	esac
	groupdel $NOME
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Grupo $NOME apagado com sucesso!" 0 0; MENU;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Tente novamente!" 0 0; AGRP;;
	6) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Grupo $NOMEinexistente" 0 0; MENU;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; MENU;;
esac
}
APAS(){
NOME=$( dialog --stdout				\
		--backtitle "ROKUKISHI PROJECT"	\
		 --ok-label Continuar		\
		--cancel-label Voltar		\
		 --inputbox "Nome do usuário" 0 0 )
	case $? in
		1|255) MENU;;
	esac
passwd $NOME
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Senha alterada com sucesso!" 0 0 ; MENU;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME não existe" 0 0; MENU;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0 ; MENU;;
esac
}
AUGR(){
	NOME=$(	dialog --stdout 			\
			--backtitle "ROKUKISHI PROJECT"	\
			 --ok-label Continuar		\
			--cancel-label Voltar 		\
			--inputbox "Nome do usuario" 0 0 )
	case $? in
		1|255) MENU;;
	esac
	GRUPO=$( dialog --stdout			\
			 --backtitle "ROKUKISHI PROJECT"\
			--ok-label Continuar		\
			--cancel-label Voltar		\
			--inputbox "Nome do grupo" 0 0 )
	case $? in
		1|255) MENU;;
	esac
	gpasswd -a  $NOME $GRUPO
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuario $NOME movido para $GRUPO" 0 0; MENU;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Tente novamente!" 0 0; AUGR;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; MENU;;
esac
}
CUSG(){
NOME=$(	dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Nome do usuário" 0 0)
case $? in
	1|255) MENU;;
esac
NOME2=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Nome do grupo" 0 0)
case $? in
	1|255) MENU;;
esac
useradd -m -s /bin/rokukishii $NOME -G $NOME2
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME criado com sucesso e inserido no grupo $NOME2!" 0 0;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Tente novamente!" 0 0; CUSR;;
	9) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Usuário $NOME já existe" 0 0; MENU;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; MENU;;
esac
dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --yesno "É necessário criar uma senha para esse usuário para poder usá-lo. Deseja fazer isso agora?" 0 0
v=$?
passw
}
MUSR(){
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /etc/passwd 0 0
case $? in
	0) MENU;;
	*) MENU;;
esac
}
MGRP(){
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /etc/group 0 0
case $? in
	0) MENU;;
	*) MENU;;
esac
}
MENU
