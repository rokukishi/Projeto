#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Reiniciar o computador"		\
	2 "Desligar o computador"		\
	3 "Configurar teclado"			\
	4 "Data e hora do sistema"		\
	5 "Calendário"				\
	6 "Alterar data do sistema"		\
	7 "Alterar hora do sistema"		\
	8 "Informações da cpu"			\
	9 "Informações de disco e partições"	\
	10 "Visualizar modulos carregados"	\
	11 "Informações do barramento PCI" 	\
	12 "Utilização de memória RAM"		\
	13 "Quantidade de INODES disponíveis"	\
	14 "Versão do Kernel "			\
	15 "Todas informações do sistema"	\
	16 "Processos do sistema"		\
	17 "Processos do sistema de forma hierarquica" \
	18 "Fechar processos" 			\
	19 "Arquivos abertos no sistema"	\
	20 "Ver INODE"				\
	21 "Voltar" )
case $OPCAO in
	1) REINPC ;;
	2) DESLIGPC ;;
	3) CONFIT ;;
	4) MDAEH ;;
	5) CALEN ;;
	6) EDATA ;;
	7) EHORA ;;
	8) INFCP ;;
	9) EXDP ;;
	10) MODC ;;
	11) PCI2 ;;
	12) UTM ;;
	13) IND ;;
	14) KERNEL ;;
	15) ALLINF ;;
	16) PROCSIS ;;
	17) PROCSISH ;;
	18) KILLPROC ;;
	19) ARQPROC ;;
	20) VINOD ;;
	21) bash /Projeto/.config/menu.sh ;;
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
function CONFIT(){
CONFIGT=$(dialog					\
	--stdout				\
	--menu "Escolha um Layout: "		\
	0 0 0					\
	1 "BR (Brasileiro)"			\
	2 "IT (Italiano)"	 		\
	3 "JP (Japônes)"			\
	4 "ES (Espanhol)"			\
	5 "US (Inglês)"				\
	6 "FR (Francês)"				\
	7 "Voltar")
case $CONFIGT in
	1) BRT ;;
	2) ITT ;;
	3) JPT ;;
	4) EST ;;
	5) UST ;;
	6) FRT ;;
	7) bash /Projeto/.config/menu.sh ;;
	*) bash /Projeto/.config/menu.sh ;;
esac
}
function BRT(){
	cp /Projeto/.config/teclado/keyboardbr /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardbr /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function ITT(){
	cp /Projeto/.config/teclado/keyboardit /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardit /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function JPT(){
	cp /Projeto/.config/teclado/keyboardjp /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardjp /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function EST(){
	cp /Projeto/.config/teclado/keyboardes /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardes /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function UST(){
	cp /Projeto/.config/teclado/keyboardus /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardus /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function FRT(){
	cp /Projeto/.config/teclado/keyboardfr /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardfr /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function REINPC(){
	dialog --infobox "Reiniciando em 3 segundos..." 0 0

	sleep 1

	init 6
}
function DESLIGPC(){

	dialog --infobox "Seu computador sera desligado em 2 segundos..." 0 0

	sleep 1

	init 0
}
menu

