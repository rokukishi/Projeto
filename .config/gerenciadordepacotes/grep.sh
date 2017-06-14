#!/bin/bash
# menu: Executar aplicativo
# menu: Entrar no terminal ( nao sei se é nesse gerenciador )
# menu: apagar dependencias de pacote
clear
function menu(){
opcao=$( dialog						\
	--stdout					\
	--backtitle "ROKUKISHI PROJECT"			\
	--ok-label Selecionar				\
	--cancel-label Voltar				\
	--title "MENU"					\
	--menu "Escolha uma opção"			\
	0 0 0						\
	1 "Instalar Aplicativos"			\
	2 "Apagar Aplicativos"				\
	3 "Importar GITHUB"				\
	4 "Atualizar Aplicativos"			\
	5 "Atualizar Repositorios"			\
	6 "Listar Pacotes" )
case $opcao in
	1) instapk ;;
	2) apgAPK ;;
	3) expGIT ;;
	4) atlAPK ;;
	5) atlREP ;;
	6) lista ;;
	*) bash /Projeto/.config/menu.sh ;;
esac
# Menu com opções para download, vizualição e remoção de pecotes
}
function instapk(){
APK=$( dialog						\
	--stdout					\
	--ok-label Continuar				\
	--cancel-label Voltar				\
	--backtitle "ROKUKISHI PROJECT"			\
	--title "Instalar aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0)
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do pacote que deseja instalar
# Caso pressione ESC ou Cancel voltará ao menu
apt-get --force-yes install $APK -y | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Instalando, aguade..." 0 0
# Comando necessário para forçar a instalação do pacote
case $? in 
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Instalado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Impossivel instalar aplicativo" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao instalar
# Caso seja 1, avisará da impossibilidade ao instalar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function apgAPK(){
APG=$( dialog						\
	--stdout					\
	--backtitle "ROKUKISHI PROJECT"			\
	--ok-label Continuar				\
	--cancel-label Voltar				\
	--title "Remover aplicativo"			\
	--inputbox "Nome do aplicativo"			\
	0 0 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do pacote que deseja remover
# Caso pressione ESC ou Cancel voltará ao menu
apt-get remove -y $APG | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Apagando, aguarde..." 0 0
# Comando necessário para forçar a remoção do pacote
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --title "Apagado com sucesso" --yesno "Deseja apagar as dependências do pacote?" 0 0; volta=$?;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Impossivel remover aplicativo" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, chamará uma função, que apagara todos os arquivos de configuração do pacote
# Caso seja 1, avisará da impossibilidade ao remover e voltará ao menu
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
case $volta in
	0) parg;;
	*) menu;;
esac
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
	--backtitle "ROKUKISHI PROJECT" 	\
	--yes-label Sim				\
	--no-label Não				\
	--title "Informação"			\
	--yesno "É necessário fazer a instalação do git. Continuar?" 0 0
# Avisará o usuário da necessidade de instalar um pacote antes de continuar
case $? in
	0) apt-get --force-yes install git -y | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Instalando, aguarde..." 0 0; gitno;;
	1) menu;;
	*) menu;;
esac
# Caso ele escolha sim, irá instalar forçadamente o git
# Caso não, voltará ao menu, assim como qualquer outra ação
}
function gitno(){
gite=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"			\
		--ok-label Continuar				\
		--cancel-label Voltar				\
		--title "Importar GITHUB"	\
		--inputbox "Nome do usuário:" 0 0 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do usuário do github
# Caso pressione ESC ou Cancel voltará ao menu
gite2=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"			\
		--ok-label Continuar				\
		--cancel-label Voltar				\
		--title "Importar GITHUB"	\
		--inputbox "Nome do repositório:" 0 0 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o nome do repositório que deseja importar para a sua máquina
# Caso pressione ESC ou Cancel voltará ao menu
git clone http://github.com/$gite/$gite2 | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Importando repositório, aguarde..." 0 0
# Comando necessário para importar o repositório, do usuário desejado
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Importado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel importar" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --title "Impossivel importar" --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao importar o repositório
# Caso seja 1, avisará da impossibilidade ao importar o repositório
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros restornos
}
function atlREP(){
dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --title "Isso pode demorar um pouco" --yesno "Deseja continuar?" 0 0
# Pedido de confirmação caso o usuário queira mesmo continuar com a atualizar
# Pois pode demorar
case $? in
	0) apt-get --force-yes update -y | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Atualizando, aguarde..." 0 0; volta=$?;;
	1) menu;;
	*) menu;;
esac
# Caso seja sim, atualizará, salvando seu retorno
# Caso seja não, voltará ao menu
case $volta in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Atualizado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivela atualizar" 0 0; menu;; 
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --title "Impossivel atualizar" --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao atualizar
# Caso seja 1, avisará da impossibilidade ao atualizar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function atlAPK(){
dialog --backtitle "ROKUKISHI PROJECT" --yes-label Sim --no-label Não --title "Isso pode demorar alguns minutos" --yesno "Deseja continuar?" 0 0
# Pedido de confirmação caso o usuário queira mesmo continuar com a atualizar
# Pois tal atualizar pode demorar muito
case $? in
	0) apt-get --force-yes upgrade -y| dialog --backtitle "ROKUKISHI PROJECT" --infobox "Atualizando, aguarde..." 0 0; volta=$?;;
	1) menu;;
	*) menu;;
esac
# Caso seja sim, atualizará, salvando seu retorno
# Caso seja não, voltará ao menu
case $volta in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Atualizado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivela atualizar" 0 0; menu;; 
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --title "Impossivel atualizar" --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao atualizar
# Caso seja 1, avisará da impossibilidade ao atualizar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function parg(){
apt-get --force-yes purge $APK -y | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Removendo dependências, aguarde..." 0 0
# Comando para apagar a força completamente o pacote
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Removido com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Impossivel remover aplicativo" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao apagar
# Caso seja 1, avisará da impossibilidade ao apagar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function lista(){
apt list --installed | nl > /tmp/listapacotes.txt
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/listapacotes.txt 0 0
menu
# Mandará a saída do comando para um arquivo temporário
# Mostrando-o todos os pacotes instalados via dialog
# Depois voltará ao menu
}
menu

