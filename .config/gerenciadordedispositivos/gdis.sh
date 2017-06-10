#!/bin/bash
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Configurar teclado"			\
	2 "Data e hora do sistema"		\
	3 "Calendário"				\
	4 "Alterar data do sistema"		\
	5 "Alterar hora do sistema"		\
	6 "Informações da cpu"			\
	7 "Informações de disco e partições"	\
	8 "Visualizar modulos carregados"	\
	9 "Informações do barramento PCI" 	\
	10 "Utilização de memória RAM"		\
	11 "Quantidade de INODES disponíveis"	\
	12 "Versão do Kernel "			\
	13 "Todas informações do sistema"	\
	14 "Processos do sistema"		\
	15 "Processos do sistema de forma hierarquica" \
	16 "Fechar processos" 			\
	17 "Arquivos abertos no sistema"	\
	18 "Ver INODE"				\
	19 "Voltar" )
case $OPCAO in
	1) CONFIT ;;
	2) MDAEH ;;
	3) CALEN ;;
	4) EDATA ;;
	5) EHORA ;;
	6) INFCP ;;
	7) EXDP ;;
	8) MODC ;;
	9) PCI2 ;;
	10) UTM ;;
	11) IND ;;
	12) KERNEL ;;
	13) ALLINF ;;
	14) PROCSIS ;;
	15) PROCSISH ;;
	16) KILLPROC ;;
	17) ARQPROC ;;
	18) VINOD ;;
	19) bash /Projeto/.config/menu.sh ;;
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
	cp /home/vagrant/Projeto/.config/keyboardbr /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardbr /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function ITT(){
	cp /home/vagrant/Projeto/.config/keyboardit /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardit /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function JPT(){
	cp /home/vagrant/Projeto/.config/keyboardjp /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardjp /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function EST(){
	cp /home/vagrant/Projeto/.config/keyboardes /etc/default/
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
	cp /home/vagrant/Projeto/.config/keyboardus /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardus /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
function FRT(){
	cp /home/vagrant/Projeto/.config/keyboardfr /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardfr /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac

}
menu
