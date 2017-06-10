#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Escolha uma das opções"		\
	0 0 0					\
	1 "Visualizar interfaces de rede"	\
	2 "Subir interface de rede"		\
	3 "Descer interface de rede"		\
	4 "Reiniciar interface de rede"	\
	5 "Visualizar Endereço IP"		\
	6 "Alterar endereço IP/Máscara" 	\
	7 "Alterar hostname"			\
	8 "Gateway"				\
	9 "Remover Gateway"			\
	10 "Adicionar Gateway"			\
	11 "Testar conexão (ping)"		\
 	12 "Voltar" )
case $OPCAO in
	1) VINT ;;
	2) SRED ;;
	3) DRED ;;
	4) REIN ;;
	5) VIP  ;;
	6) ATIP ;;
	7) ATHS ;;
	8) GTWY ;;
	9) RTWY ;;
	10) DTWY ;; 
	11) PING ;;
	12) bash /Projeto/.config/menu.sh;;
	*) bash /Projeto/.config/menu.sh;;
esac
# Um menu com algumas opções que permitem o usuário gerenciar sua rede
# Caso queira voltar, é só pressionar ESC, Cancel ou escolher a opção 11
}
function VINT(){
ip addr > /tmp/vint.txt
# Manda as informações das interfaces de rede para um arquivo temporário
dialog --textbox /tmp/vint.txt 0 0
# Mostra esse arquivo via dialog
case $? in
	0) menu;;
	1|255) menu;;
esac
# Caso Seja pressionado ESC ou Cancel, voltará ao menu
}
function SRED(){
ip addr > /tmp/interface.txt
# Manda as informações das interfaces de rede para um arquivo temporário
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja ligar
# De acordo com as informações vistas anteriormente
ifconfig eth$int up
# Comando para ligar a interface (eth) escolhida pelo usuário
case $? in
	0) dialog --msgbox "Ligada com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel ligar" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará o usuário que a interface ligou com sucesso
# Caso seja 1, avisará da impossibilidade ao ligar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
# Assim como os outros retornos
}
function DRED(){
ip addr > /tmp/interface.txt
# Manda as informações das interfaces de rede para um arquivo temporário
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja desligar
# De acordo com as informações vistas anteriormente
ifconfig eth$int down
# Comando para desligar a interface (eth) escolhida pelo usuário
case $? in
	0) dialog --msgbox "Desligada com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel desligar" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará o usuário que a interface desligou com sucesso
# Caso seja 1, avisará da impossibilidade ao desligar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
# Assim como os outros retornos
}
function REIN(){
ip addr > /tmp/interface.txt
# Manda as informações das interfaces de rede para um arquivo temporário
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja reiniciar
# De acordo com as informações vistas anteriormente
/etc/init.d/networking restart
# Comando para reiniciar a interface (eth) escolhida pelo usuário
case $? in
	0) dialog --msgbox "Reiniciada com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel reiniciar" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará o usuário que a interface reiniciou com sucesso
# Caso seja 1, avisará da impossibilidade ao reiniciar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
# Assim como os outros retornos
}
function VIP(){
hostname -I > /tmp/ipip.txt
# Mandará o endereço ip via comando para um arquivo temporário
dialog --textbox /tmp/ipip.txt 0 0
menu
# Mostrará esse arquivo via dialog e retorna ao menu
}
function ATIP(){
ip addr > /tmp/interface.txt
# Manda as informações das interfaces de rede para um arquivo temporário
	dialog                        	  \
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--title "Escolha a interface"	\
		--inputbox "Interface número:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja desligar
# De acordo com as informações vistas anteriormente
ip addr flush dev eth$int
# Comando necessário para deletar o endereço ip da interface escolhida
menu=$( dialog					\
		--stdout			\
		--menu "IP"			\
		0 0 0				\
		1 "DHCP"			\
		2 "Estático"			\
		3 "Voltar" )
case $menu in
	1) dhclient eth$int; menu;;
	2) estatico;;
	3) menu;;
	*) menu;;
esac
# Menu com opção de ecolher ip dhco ou estático, fazendo o usuário digitar tal endereço
# Caso queira voltar, pressione ESC ou Cancel, ou selecione a opção 3
}
function estatico(){
ip=$( dialog 				\
	--stdout			\
	--inputbox "Address:" 0 0 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o endereço ip, ex.: 192.168.0.1
# Caso pressione Cancel ou ESC, voltará ao menu
mask=$( dialog 				\
	--stdout			\
	--menu "Netmask:"		\
		0 0 0			\
		1 "Padrão"			\
		2 "255.255.255.252"		\
		3 "255.255.255.248"		\
		4 "255.255.255.240"		\
		5 "255.255.255.224"		\
		6 "255.255.255.192"		\
		7 "255.255.255.128"		\
		8 "255.255.255.0"		\
		9 "255.255.254.0"		\
		10 "255.255.252.0"		\
		11 "255.255.248.0"		\
		12 "255.255.240.0"		\
		13 "255.255.224.0"		\
		14 "255.255.192.0"		\
		15 "255.255.128.0"		\
		16 "255.255.0.0"		\
		17 "255.254.0.0"		\
		18 "255.252.0.0"		\
		19 "255.248.0.0"		\
		20 "255.240.0.0"		\
		21 "255.224.0.0"		\
		22 "255.192.0.0"		\
		23 "255.128.0.0"		\
		24 "255.0.0.0"			\
		25 "Voltar" )
case $mask in
	1) padrao;;
	2) mask=30;;
	3) mask=29;;
	4) mask=28;;
	5) mask=27;;
	6) mask=26;;
	7) mask=25;;
	8) mask=24;;
	9) mask=23;;
	10) mask=22;;
	11) mask=21;;
	12) mask=20;;
	13) mask=19;;
	14) mask=18;;
	15) mask=17;;
	16) mask=16;;
	17) mask=15;;
	18) mask=14;;
	19) mask=13;;
	20) mask=12;;
	21) mask=11;;
	22) mask=10;;
	23) mask=9;;
	24) mask=8;;
	25) menu;;
	*) menu;;
esac
masc
# Aqui será selecionada a máscara da rede
# Caso o usuário não tenha conhecimento sobre máscaras de rede, poderá escolher padrão
# Caso selecione a opção 25 ou Pressione Cancel ou ESC, retornará ao menu
# Chamando um função no final
}
function padrao(){
case $ip in
	192.168.0.*) mask=24;;
	172.16.*) mask=16;;
	10.*) mask=8;;
	*) mask=24;;
esac
masc
# Aqui se Define algumas máscaras padrões de acordo com o que o usuário digitar como ip
# Chamando um função no final
}
function masc(){
ip addr add $ip/$mask dev eth$int
# Com as informações dadas pelo usuário será dado o novo endereço ip a interface escolhida, assim como a máscara
case $? in
	0) dialog --msgbox "Alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel alterar. Tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao alterar ip e mascara
# Reiniciando assim a interface de rede
# Caso seja 1, avisará da impossibilidade ao alterar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function ATHS (){
	dialog                        	 	\
	--title "Hostname" 			\
	--textbox /etc/hostname 0 0
# Mostra ao usuário o hostname atual
int=$( dialog					\
		--stdout			\
		--title "Altere o Host"		\
		--inputbox "Digite o novo nome:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o novo nome do hostname
# Caso pressione ESC ou Cancel voltará ao menu
echo "$int" > /etc/hostname
# Substituirá o conteudo do arquivo de configuração do hostname para o nome que o usuário escolheu
# ALterando o hostname
case $? in
	0) dialog --msgbox "Host alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar o host" 0 0; menu;;
 	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao alterar o hostname
# Caso seja 1, avisará da impossibilidade ao alterar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function GTWY(){
	route -n > /tmp/route.txt
# Mandará via comando o gataway da rede para um arquivo temporário
	dialog --textbox /tmp/route.txt 0 0
	menu
# Mostrará ao usuário esse arquivo, voltando ao menu após isso
}
function RTWY(){
ip addr > /tmp/inter.txt
# Mandará via comando as interfaces da rede para um arquivo temporário
dialog --title "Interfaces" --textbox /tmp/inter.txt 0 0
# Mostrará ao usuário esse arquivo
int=$(dialog --stdout --title "Remover Gateway" --inputbox "Interface:" 0 0)
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário que digite o número da interface que deseja remover o gateway
# Caso pressione ESC ou Cancel voltará ao menu
GW=$(dialog --stdout --title -"Remover Gateway" --inputbox "Gateway:" 0 0)
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário que digite o número do gateway que deseja remover
# Caso pressione ESC ou Cancel voltará ao menu
	route del $GW eth$int
# Comando necessário para remover o gateway da interface que o usuário selecionou
case $? in
	0) dialog --msgbox "Removido com sucesso" 0 0; menu;;
	1|7) dialog --msgbox "Não foi possivel remover o gateway" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao remover o gateway
# Caso seja 1, avisará da impossibilidade ao remover
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function DTWY(){
ip addr > /tmp/gat.txt
# Mandará via comando as interfaces da rede para um arquivo temporário
dialog --textbox /tmp/gat.txt 0 0
# Mostrará ao usuário esse arquivo
int=$(dialog --stdout --title "Adicionar gateway" --inputbox "Interface:" 0 0)
case $? in
	1|255) menu ;;
esac
# Pedirá ao usuário que digite o número da interface que deseja adicionar um gateway
# Caso pressione ESC ou Cancel voltará ao menu
Gd=$(dialog --stdout --title "Adicionar gateway" --inputbox "Gateway:" 0 0)
case $? in
	1|255) menu ;;
esac
# Pedirá ao usuário que digite o número do gateway que deseja adicionar
# Caso pressione ESC ou Cancel voltará ao menu
	route add $Gd eth$int
# Comando necessário para adicionar o gateway na interface que o usuário selecionou
case $? in
	0) dialog --msgbox "Adicionado com sucesso" 0 0; menu;;
	1|7) dialog --msgbox "Não foi possivel adicionar o gateway" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao adicionar o gateway
# Caso seja 1, avisará da impossibilidade ao adicionar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function PING(){
	PN=$(dialog --stdout --inputbox "IP:" 0 0)
case $? in
	1|255) menu;;
esac
# Pede ao usuário que digite o ip que deseja testar a conexão
ping -c 6 $PN > /tmp/pingar.log | dialog --title "Pingando $PN" --tailbox /tmp/pingar.log 100 100
case $? in
	0) menu;;
	1) dialog --msgbox "Endereço IP não encontrado" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, voltará ao menu após o ping
# Caso seja 1, avisará que não foi possivel encontrar o ip digitado
# Caso o retorno seja desconhecido, mostrará o erro ocorrido e voltará ao menu
}
menu
