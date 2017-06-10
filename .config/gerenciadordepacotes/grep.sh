#!/bin/bash
clear
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "MENU"					\
	--menu "Escolha uma opção"			\
	0 0 0						\
	1 "Instalar Aplicativos"			\
	2 "Apagar Aplicativos"				\
	3 "Importar GITHUB"				\
	4 "Atualizar Aplicativos"			\
	5 "Atualizar Repositorios"			\
	6 "Listar Pacotes"				\
	7 "Voltar" )
case $opcao in
	1) instapk ;;
	2) apgAPK ;;
	3) expGIT ;;
	4) atlAPK ;;
	5) atlREP ;;
	6) lista ;;
	7) bash /Projeto/.config/menu.sh ;;
	*) bash /Projeto/.config/menu.sh ;;
esac
# Menu com opções para download, vizualição e remoção de pecotes
}
function instapk(){
APK=$( dialog						\
	--stdout					\
	--title "Instalar aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	5 40)
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do pacote que deseja instalar
# Caso pressione ESC ou Cancel voltará ao menu
apt-get --force-yes install $APK -y > /tmp/instalar.log | dialog --title "Instalando $APK" --tailbox /tmp/instalar.log 100 100
# Comando necessário para forçar a instalação do pacote
case $? in
	0) dialog --msgbox "Instalado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel instalar aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao instalar
# Caso seja 1, avisará da impossibilidade ao instalar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function apgAPK(){
APG=$( dialog						\
	--stdout					\
	--title "Remover aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	5 40 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do pacote que deseja remover
# Caso pressione ESC ou Cancel voltará ao menu
apt-get remove -y $APG > /tmp/apg.log | dialog --title "Aguarde" --tailbox /tmp/apg.log 100 100
# Comando necessário para forçar a remoção do pacote
case $? in
	0) parg;;
	1) dialog --msgbox "Impossivel remover aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, chamará uma função, que apagara todos os arquivos de configuração do pacote
# Caso seja 1, avisará da impossibilidade ao remover e voltará ao menu
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
}
function expGIT(){
git > /tmp/gittest.txt
# Mandará a saída dum comando para um arquivo temporário
case $? in
	127) gityes;;
	1) gitno;;
esac
# Fazendo isso saberemos da existencia do pacote ou não, chamando assim uma função dependendo do retorno
}
function gityes(){
dialog					\
	--title "Informação"			\
	--yesno "È necessário fazer a instalação do git. Continuar?" 5 40
# Avisará o usuário da necessidade de instalar um pacote antes de continuar
case $? in
	0) apt-get --force-yes install git -y > /tmp/gitinst.log | dialog --title "Instalando Github" --tailbox /tmp/gitinst.log 100 100; gitno;;
	1) menu;;
	*) menu;;
esac
# Caso ele escolha sim, irá instalar forçadamente o git
# Caso não, voltará ao menu, assim como qualquer outra ação
}
function gitno(){
gite=$( dialog					\
		--stdout			\
		--title "Importar GITHUB"	\
		--inputbox "Nome do usuário:" 5 40 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do usuário do github
# Caso pressione ESC ou Cancel voltará ao menu
gite2=$( dialog					\
		--stdout			\
		--title "Importar GITHUB"	\
		--inputbox "Nome do repositório:" 5 40 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do repositório que deseja importar para a sua máquina
# Caso pressione ESC ou Cancel voltará ao menu
git clone http://github.com/$gite/$gite2
# Comando necessário para importar o repositório, do usuário desejado
case $? in
	0) dialog --msgbox "Importado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel importar" 0 0; menu;;
	*) dialog --title "Impossivel importar" --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao importar o repositório
# Caso seja 1, avisará da impossibilidade ao importar o repositório
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros restornos
}
function atlREP(){
dialog --title "Isso pode demorar um pouco" --yesno "Deseja continuar?" 5 40
# Pedido de confirmação caso o usuário queira mesmo continuar com a atualizar
# Pois pode demorar
case $? in
	0) apt-get update > /tmp/att.log | dialog --title "Atualizando" --tailbox /tmp/att.log 100 100; volta=$?;;
	1) menu;;
esac
# Caso seja sim, atualizará, salvando seu retorno
# Caso seja não, voltará ao menu
case $volta in
	0) dialog --msgbox "Atualizado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivela atualizar" 0 0; menu;; 
	*) dialog --title "Impossivel atualizar" --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao atualizar
# Caso seja 1, avisará da impossibilidade ao atualizar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function atlAPK(){
dialog --title "Isso pode demorar alguns minutos" --yesno "Deseja continuar?" 5 40
# Pedido de confirmação caso o usuário queira mesmo continuar com a atualizar
# Pois tal atualizar pode demorar muito
case $? in
	0) apt-get upgrade > /tmp/att.log | dialog --title "Atualizando" --tailbox /tmp/att.log; volta=$?;;
	1) menu;;
esac
# Caso seja sim, atualizará, salvando seu retorno
# Caso seja não, voltará ao menu
case $volta in
	0) dialog --msgbox "Atualizado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivela atualizar" 0 0; menu;; 
	*) dialog --title "Impossivel atualizar" --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao atualizar
# Caso seja 1, avisará da impossibilidade ao atualizar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function parg(){
apt-get purge $APK -y > /tmp/apg.log | dialog --title "Apagando" --tailbox /tmp/apg.log 100 100
# Comando para apagar a força completamente o pacote
case $? in
	0) dialog --msgbox "Removido com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel remover aplicativo" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao apagar
# Caso seja 1, avisará da impossibilidade ao apagar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function lista(){
apt list --installed | nl > /tmp/listapacotes.txt
dialog --textbox /tmp/listapacotes.txt 0 0
menu
# Mandará a saída do comando para um arquivo temporário
# Mostrando-o todos os pacotes instalados via dialog
# Depois voltará ao menu
}
menu

