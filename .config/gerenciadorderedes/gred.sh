#!/bin/bash
# menu: apagar ip
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--backtitle "ROKUKISHI PROJECT"		\
	--ok-label Selecionar			\
	--cancel-label Voltar			\
	--menu "Escolha uma das opções"		\
	0 0 0					\
	1 "Visualizar interfaces de rede"	\
	2 "Subir interface de rede"		\
	3 "Descer interface de rede"		\
	4 "Reiniciar interface de rede"	\
	5 "Visualizar Endereço IP"		\
	6 "Alterar endereço IP/Máscara" 	\
	7 "Adicionar IP"			\
	8 "Alterar hostname"			\
	9 "Gateway"				\
	10 "Remover Gateway"			\
	11 "Adicionar Gateway"			\
	12 "Testar conexão (ping)")
case $OPCAO in
	1) VINT ;;
	2) SRED ;;
	3) DRED ;;
	4) REIN ;;
	5) VIP  ;;
	6) ATIP ;;
	7) ADDIP ;;
	8) ATHS ;;
	9) GTWY ;;
	10) RTWY ;;
	11) DTWY ;;
	12) PING ;;
	*) bash /Projeto/.config/menu.sh;;
esac
# Um menu com algumas opções que permitem o usuário gerenciar sua rede
# Caso queira voltar, é só pressionar ESC, Cancel ou escolher a opção 11
}
function VINT(){
ip addr > /tmp/vint.txt
# Manda as informações das interfaces de rede para um arquivo temporário
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/vint.txt 0 0
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
	dialog                        	  	\
	--backtitle "ROKUKISHI PROJECT"		\
	 --exit-label Sair			\
	--title "Interfaces" 			\
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT" \
		--ok-label Continuar		\
		--cancel-l�abel Voltar		\
		--title "Escolha a interface"	\
		--inputbox "Interface:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja ligar
# De acordo com as informações vistas anteriormente
ifconfig eth$int up
# Comando para ligar a interface (eth) escolhida pelo usuário
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Ligada com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel ligar" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
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
	--backtitle "ROKUKISHI PROJECT" 	\
	--exit-label Sair			\
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"	\
		 --ok-label Continuar		\
		--cancel-label Voltar		\
		--title "Escolha a interface"	\
		--inputbox "Interface:"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja desligar
# De acordo com as informações vistas anteriormente
ifconfig eth$int down
# Comando para desligar a interface (eth) escolhida pelo usuário
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Desligada com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel desligar" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará o usuário que a interface desligou com sucesso
# Caso seja 1, avisará da impossibilidade ao desligar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
# Assim como os outros retornos
}
function REIN(){
service networking restart | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando Interface de rede" 0 0
# Comando para reiniciar a interface escolhida pelo usuário
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Reiniciada com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel reiniciar" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará o usuário que a interface reiniciou com sucesso
# Caso seja 1, avisará da impossibilidade ao reiniciar
# Caso seja um retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
# Assim como os outros retornos
}
function VIP(){
hostname -I > /tmp/ipip.txt
# Mandará o endereço ip via comando para um arquivo temporário
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ipip.txt 0 0
menu
# Mostrará esse arquivo via dialog e retorna ao menu
}
function ATIP(){
ip addr > /tmp/interface.txt
# Manda as informações das interfaces de rede para um arquivo temporário
	dialog                        	  \
	--backtitle "ROKUKISHI PROJECT"		\
	--exit-label Sair		\
	--title "Interfaces" \
	--textbox /tmp/interface.txt 0 0
# Mostra esse arquivo via dialog
int=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"	\
		 --ok-label Continuar		\
		--cancel-label Voltar		\
		--title "Escolha a interface"	\
		--inputbox "Interface"	\
		0 0 )
case $? in
	1|255) menu;;
esac
# Pede para que o usuário digite o número da interface que deseja desligar
# De acordo com as informações vistas anteriormente
ip addr flush dev $int
# Comando necessário para deletar o endereço ip da interface escolhida
menu=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"	\
		--ok-label Selecionar		\
		--cancel-label Voltar		\
		--menu "IP"			\
		0 0 0				\
		1 "DHCP"			\
		2 "Estático" )
case $menu in
	1) dhccp;;
	2) estatico;;
	*) menu;;
esac
# Menu com opção de ecolher ip dhco ou estático, fazendo o usuário digitar tal endereço
# Caso queira voltar, pressione ESC ou Cancel, ou selecione a opção 3
}
function estatico(){
ip=$( dialog 				\
	--stdout			\
	--backtitle "ROKUKISHI PROJECT"	\
	--ok-label Continuar		\
	--cancel-label Voltar		\
	--inputbox "Address:" 0 0 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário digitar o endereço ip, ex.: 192.168.0.1
# Caso pressione Cancel ou ESC, voltará ao menu
mask=$( dialog 				\
	--stdout			\
	--backtitle "ROKUKISHI PROJECT"	\
	--ok-label Selecionar		\
	--cancel-label Voltar		\
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
		24 "255.0.0.0" )
case $mask in
	1) padrao;;
	2) mask="255.255.255.252";;
	3) mask="255.255.255.248";;
	4) mask="255.255.255.240";;
	5) mask="255.255.255.224";;
	6) mask="255.255.255.192";;
	7) mask="255.255.255.128";;
	8) mask="255.255.255.0";;
	9) mask="255.255.254.0";;
	10) mask="255.255.252.0";;
	11) mask="255.255.248.0";;
	12) mask="255.255.240.0";;
	13) mask="255.255.224.0";;
	14) mask="255.255.192.0";;
	15) mask="255.255.128.0";;
	16) mask="255.255.0.0";;
	17) mask="255.254.0.0";;
	18) mask="255.252.0.0";;
	19) mask="255.248.0.0";;
	20) mask="255.240.0.0";;
	21) mask="255.224.0.0";;
	22) mask="255.192.0.0";;
	23) mask="255.128.0.0";;
	24) mask="255.0.0.0";;
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
	192.168.0.*) mask="255.255.255.0";;
	172.16.*) mask="255.255.0.0";;
	10.*) mask="255.0.0.0";;
	*) mask="255.255.255.0";;
esac
masc
# Aqui se Define algumas máscaras padrões de acordo com o que o usuário digitar como ip
# Chamando um função no final
}
function masc(){
mv /Projeto/.config/ip/estaticoedhcp /Projeto/.config/ip/interfaces
cp /Projeto/.config/ip/interfaces /Projeto/.config/ip/estaticoedhcp
echo >> /Projeto/.config/ip/interfaces
echo "auto $int" >> /Projeto/.config/ip/interfaces
echo "allow-hotplug $int" >> /Projeto/.config/ip/interfaces
echo "iface $int inet static" >> /Projeto/.config/ip/interfaces
echo "address $ip" >> /Projeto/.config/ip/interfaces
echo "netmask $mask" >> /Projeto/.config/ip/interfaces
mv /Projeto/.config/ip/interfaces /etc/network/interfaces
service networking restart | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando interface de rede" 0 0
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Alterado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Impossivel alterar. Tente novamente" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao alterar ip e mascara
# Reiniciando assim a interface de rede
# Caso seja 1, avisará da impossibilidade ao alterar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function dhccp(){
mv /Projeto/.config/ip/estaticoedhcp /Projeto/.config/ip/interfaces
cp /Projeto/.config/ip/interfaces /Projeto/.config/ip/estaticoedhcp
echo >> /Projeto/.config/ip/interfaces
echo "allow-hotplug $int" >> /Projeto/.config/ip/interfaces
echo "iface $int inet dhcp" >> /Projeto/.config/ip/interfaces
mv /Projeto/.config/ip/interfaces /etc/network/interfaces
service networking restart | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando interface de rede" 0 0
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Alterado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Impossivel alterar. Tente novamente" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao alterar ip e mascara
# Reiniciando assim a interface de rede
# Caso seja 1, avisará da impossibilidade ao alterar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function ADDIP(){
ip addr > /tmp/rede.txt
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Continuar --title "Interfaces" --textbox /tmp/rede.txt 0 0
int=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"	\
		 --ok-label Continuar		\
		--cancel-label Voltar		\
		--title "Escolha a interface"	\
		--inputbox "Interface"	\
		0 0 )
case $? in
	1|255) menu;;
esac
ip=$( dialog 				\
	--stdout			\
	--backtitle "ROKUKISHI PROJECT"	\
	--ok-label Continuar		\
	--cancel-label Voltar		\
	--inputbox "Address:" 0 0 )
case $? in
	1|255) menu;;
esac
mask=$( dialog 				\
	--stdout			\
	--backtitle "ROKUKISHI PROJECT"	\
	--ok-label Selecionar		\
	--cancel-label Voltar		\
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
		24 "255.0.0.0" )
case $mask in
	1) pad;;
	2) mask="255.255.255.252";;
	3) mask="255.255.255.248";;
	4) mask="255.255.255.240";;
	5) mask="255.255.255.224";;
	6) mask="255.255.255.192";;
	7) mask="255.255.255.128";;
	8) mask="255.255.255.0";;
	9) mask="255.255.254.0";;
	10) mask="255.255.252.0";;
	11) mask="255.255.248.0";;
	12) mask="255.255.240.0";;
	13) mask="255.255.224.0";;
	14) mask="255.255.192.0";;
	15) mask="255.255.128.0";;
	16) mask="255.255.0.0";;
	17) mask="255.254.0.0";;
	18) mask="255.252.0.0";;
	19) mask="255.248.0.0";;
	20) mask="255.240.0.0";;
	21) mask="255.224.0.0";;
	22) mask="255.192.0.0";;
	23) mask="255.128.0.0";;
	24) mask="255.0.0.0";;
	*) menu;;
esac
addd
}
function pad(){
case $ip in
	192.168.0.*) mask="255.255.255.0";;
	172.16.*) mask="255.255.0.0";;
	10.*) mask="255.0.0.0";;
	*) mask="255.255.255.0";;
esac
addd
}
function addd(){
grep :1 /etc/network/interfaces
case $? in
	1) echo >> /etc/network/interfaces; echo "auto $int:1" >> /etc/network/interfaces; echo "iface $int:1 inet static" >> /etc/network/interfaces; echo "address $ip" >> /etc/network/interfaces; echo "netmask $mask" >> /etc/network/interfaces; service networking restart | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando interface de rede" 0 0; service networking restart; dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Adicionado com sucesso" 0 0; menu;;
esac
n=1
until (( $? == 1 )); do
	let n=$n+1
	grep :$n /etc/network/interfaces
done
echo >> /etc/network/interfaces
echo "auto $int:$n" >> /etc/network/interfaces
echo "iface $int:$n inet static" >> /etc/network/interfaces
echo "address $ip" >> /etc/network/interfaces
echo "netmask $mask" >> /etc/network/interfaces
service networking restart | dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando interface de rede" 0 0
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Adicionado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel adicionar" 0 0; menu;;
esac
}
function ATHS (){
	dialog                        	 	\
	--backtitle "ROKUKISHI PROJECT" 	\
	--exit-label Sair			\
	--title "Hostname" 			\
	--textbox /etc/hostname 0 0
# Mostra ao usuário o hostname atual
int=$( dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"	\
		--ok-label Continuar		\
		--cancel-label Voltar		\
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
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Host alterado com sucesso" 0 0; menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel alterar o host" 0 0; menu;;
 	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao alterar o hostname
# Caso seja 1, avisará da impossibilidade ao alterar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function GTWY(){
	route -n > /tmp/route.txt
# Mandará via comando o gataway da rede para um arquivo temporário
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/route.txt 0 0
	menu
# Mostrará ao usuário esse arquivo, voltando ao menu após isso
}
function RTWY(){
ip addr > /tmp/inter.txt
# Mandará via comando as interfaces da rede para um arquivo temporário
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair--title "Interfaces" --textbox /tmp/inter.txt 0 0
# Mostrará ao usuário esse arquivo
int=$(dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --title "Remover Gateway" --inputbox "Interface:" 0 0)
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário que digite o número da interface que deseja remover o gateway
# Caso pressione ESC ou Cancel voltará ao menu
GW=$(dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --title -"Remover Gateway" --inputbox "Gateway:" 0 0)
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário que digite o número do gateway que deseja remover
# Caso pressione ESC ou Cancel voltará ao menu
	route del $GW eth$int
# Comando necessário para remover o gateway da interface que o usuário selecionou
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Removido com sucesso" 0 0; menu;;
	1|7) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel remover o gateway" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao remover o gateway
# Caso seja 1, avisará da impossibilidade ao remover
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function DTWY(){
ip addr > /tmp/gat.txt
# Mandará via comando as interfaces da rede para um arquivo temporário
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/gat.txt 0 0
# Mostrará ao usuário esse arquivo
int=$(dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --title "Adicionar gateway" --inputbox "Interface:" 0 0)
case $? in
	1|255) menu ;;
esac
# Pedirá ao usuário que digite o número da interface que deseja adicionar um gateway
# Caso pressione ESC ou Cancel voltará ao menu
Gd=$(dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --title "Adicionar gateway" --inputbox "Gateway:" 0 0)
case $? in
	1|255) menu ;;
esac
# Pedirá ao usuário que digite o número do gateway que deseja adicionar
# Caso pressione ESC ou Cancel voltará ao menu
	route add $Gd eth$int
# Comando necessário para adicionar o gateway na interface que o usuário selecionou
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Adicionado com sucesso" 0 0; menu;;
	1|7) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel adicionar o gateway" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, avisará do sucesso ao adicionar o gateway
# Caso seja 1, avisará da impossibilidade ao adicionar
# Caso seja um retorno desconhecido, mostrará o erro e voltará ao menu assim como os outros retornos
}
function PING(){
	PN=$(dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "IP:" 0 0)
case $? in
	1|255) menu;;
esac
# Pede ao usuário que digite o ip que deseja testar a conexão
ping -c 6 $PN > /tmp/pingar.log | dialog --backtitle "ROKUKISHI PROJECT" --title "Pingando $PN" --tailbox /tmp/pingar.log 100 100
case $? in
	0) menu;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Endereço IP não encontrado" 0 0; menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, voltará ao menu após o ping
# Caso seja 1, avisará que não foi possivel encontrar o ip digitado
# Caso o retorno seja desconhecido, mostrará o erro ocorrido e voltará ao menu
}
menu
