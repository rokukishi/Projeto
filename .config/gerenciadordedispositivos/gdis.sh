#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Data e hora do sistema"		\
	2 "Calendário"				\
	3 "Alterar data do sistema"		\
	4 "Alterar hora do sistema"		\
	5 "Informações da cpu"			\
	6 "Informações de disco e partições"	\
	7 "Visualizar modulos carregados"	\
	8 "Informações do barramento PCI" 	\
	9 "Utilização de memória RAM"		\
	10 "Quantidade de INODES disponíveis"	\
	11 "Versão do Kernel "			\
	12 "Todas informações do sistema"	\
	13 "Processos do sistema"		\
	14 "Processos do sistema de forma hierarquica" \
	15 "Fechar processos" 			\
	16 "Arquivos abertos no sistema" \
	17 "Ver INODE"				\
	18 "Voltar" )
case $OPCAO in
	1) MDAEH ;;
	2) CALEN ;;
	3) EDATA ;;
	4) EHORA ;;
	5) INFCP ;;
	6) EXDP ;;
	7) MODC ;;
	8) PCI2 ;;
	9) UTM ;;
	10) IND ;;
	11) KERNEL ;;
	12) ALLINF ;;
	13) PROCSIS ;;
	14) PROCSISH ;;
	15) KILLPROC ;;
	16) ARQPROC ;;
	17) VINOD ;;
	18) bash /Projeto/.config/menu.sh ;;
	*) bash /Projeto/.config/menu.sh ;;
esac
}
function MDAEH(){
date > /tmp/datahora.txt
dialog --textbox /tmp/datahora.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function CALEN(){
dialog --title "Calendário" --calendar '' 0 0
case $? in
	*) menu;;
esac
}
function EDATA(){
mes=$( dialog --stdout --inputbox "Mês:" 0 0 )
case $? in
	1|255) menu;;
esac
dia=$( dialog --stdout --inputbox "Dia:" 0 0 )
case $? in
	1|255) menu;;
esac
ano=$( dialog --stdout --inputbox "Ano:" 0 0 )
case $? in
	1|255) menu;;
esac
hora=$( dialog --stdout --inputbox "Hora:" 0 0 )
case $? in
	1|255) menu;;
esac
minuto=$( dialog --stdout --inputbox "Minutos:" 0 0 )
case $? in
	1|255) menu;;
esac
date $mes$dia$hora$minuto$ano
date > /tmp/data.txt
dialog --textbox /tmp/data.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function EHORA(){
horas=$(dialog					\
		--stdout			\
		--title "Ajustar o relógio"	\
		--timebox "/nDica: use as setas e o TAB" 0 0 )
date +%T -s $horas
date +%T > /tmp/hora.txt
dialog --textbox /tmp/hora.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function INFCP(){
	lscpu > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function EXDP(){
	fdisk -l > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function MODC(){
	lsmod > /tmp/cpuinf.txt
	dialog --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function PCI2(){
	lspci -vv > /tmp/pciinf.txt
	dialog --textbox /tmp/pciinf.txt 0 0

case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function UTM(){
	free -h > /tmp/infmem.txt
	dialog --textbox /tmp/infmem.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function IND(){
	df -ih > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function KERNEL(){
	uname -v > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function ALLINF(){
	uname -a > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function PROCSIS(){
	ps aux > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function PROCSISH(){
	pstree > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function KILLPROC(){
	kill=$(dialog --stdout --inputbox "Digite o PID do processo que deseja fechar: " 8 50)
case $? in
	1|255) menu;;
esac
	kill -9 $kill
case $? in
	0) dialog --msgbox "Encerrado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel encerrar processo" 0 0; menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function ARQPROC(){
	lsof > /tmp/ino.txt
	dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --infobox "erro: $?" 0 0; menu;;
esac
}
function ARQPROC(){
lsof > /tmp/ino.txt
dialog --textbox /tmp/ino.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}
function VINOD(){
dialog --msgbox "Não se esqueça de usar / quando desejar ver INODES de diretório" 0 0
dialog --msgbox "Digite o caminho completo para arquivos em outros diretórios" 0 0
ino=$( dialog --stdout --inputbox "Nome do arquivo/diretório" 0 0 )
case $? in
	1|255) menu;;
esac
ls -i $ino > /tmp/ino.txt
dialog --title "INODE: $ino" --textbox /tmp/ino.txt 0 0 
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
}

menu
