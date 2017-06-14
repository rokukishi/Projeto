#!/bin/bash
# nenhuma ideia ate agr kkkkkkkkkkkkkkkkkkk
function menu(){
OPCAO=$(dialog					\
	--stdout				\
	--backtitle "ROKUKISHI PROJECT"		\
	--ok-label Selecionar			\
	--cancel-label Voltar			\
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
	11 "Próxima página" )

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
	11) PROX ;;
	*) bash /Projeto/.config/menu.sh ;;
esac
}
function PROX(){
OPCAO=$(dialog					\
	--stdout				\
	--backtitle "ROKUKISHI PROJECT"		\
	--ok-label Selecionar			\
	--cancel-label Voltar			\
	--menu "Gerenciador de dispositivos"	\
	0 0 0					\
	1 "Informações do barramento PCI" 	\
	2 "Utilização de memória RAM"		\
	3 "Quantidade de INODES disponíveis"	\
	4 "Versão do Kernel "			\
	5 "Todas informações do sistema"	\
	6 "Processos do sistema"		\
	7 "Processos do sistema de forma hierarquica" \
	8 "Fechar processos" 			\
	9 "Arquivos abertos no sistema"	\
	10 "Ver INODE" )
case $OPCAO in
	1) PCI2 ;;
	2) UTM ;;
	3) IND ;;
	4) KERNEL ;;
	5) ALLINF ;;
	6) PROCSIS ;;
	7) PROCSISH ;;
	8) KILLPROC ;;
	9) ARQPROC ;;
	10) VINOD ;;
	*) menu ;;
esac
}
function MDAEH(){
date > /tmp/datahora.txt
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/datahora.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
}
function CALEN(){
dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --title "Calendário" --calendar '' 0 0
case $? in
	*) menu;;
esac
}
function EDATA(){
mes=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Mês:" 0 0 )
case $? in
	1|255) menu;;
esac
dia=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Dia:" 0 0 )
case $? in
	1|255) menu;;
esac
ano=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Ano:" 0 0 )
case $? in
	1|255) menu;;
esac
hora=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Hora:" 0 0 )
case $? in
	1|255) menu;;
esac
minuto=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Minutos:" 0 0 )
case $? in
	1|255) menu;;
esac
date $mes$dia$hora$minuto$ano
date > /tmp/data.txt
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/data.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
}
function EHORA(){
horas=$(dialog					\
		--stdout			\
		--backtitle "ROKUKISHI PROJECT"	\
		--ok-label Continuar		\
		--cancel-label Voltar		\
		--title "Ajustar o relógio"	\
		--timebox "Dica: use as setas e o TAB" 0 0 )
date +%T -s $horas
date +%T > /tmp/hora.txt
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/hora.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac
}
function INFCP(){
	lscpu > /tmp/cpuinf.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; menu;;
esac
}
function EXDP(){
	fdisk -l > /tmp/cpuinf.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; menu;;
esac
}
function MODC(){
	lsmod > /tmp/cpuinf.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/cpuinf.txt 0 0
case $? in
	0) menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; menu;;
esac
}
function PCI2(){
	lspci -vv > /tmp/pciinf.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/pciinf.txt 0 0

case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function UTM(){
	free -h > /tmp/infmem.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/infmem.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function IND(){
	df -ih > /tmp/ino.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ino.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function KERNEL(){
	uname -v > /tmp/ino.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ino.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function ALLINF(){
	uname -a > /tmp/ino.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ino.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function PROCSIS(){
	ps aux > /tmp/ino.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ino.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function PROCSISH(){
	pstree > /tmp/ino.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ino.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function KILLPROC(){
	kill=$(dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Digite o PID do processo que deseja fechar: " 8 50)
case $? in
	1|255) PROX;;
esac
	kill -9 $kill
case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Encerrado com sucesso" 0 0; PROX;;
	1) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não foi possivel encerrar processo" 0 0; PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function ARQPROC(){
	lsof > /tmp/ino.txt
	dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --textbox /tmp/ino.txt 0 0
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "erro: $?" 0 0; PROX;;
esac
}
function VINOD(){
dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Não se esqueça de usar / quando desejar ver INODES de diretório" 0 0
dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Digite o caminho completo para arquivos em outros diretórios" 0 0
ino=$( dialog --stdout --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --cancel-label Voltar --inputbox "Nome do arquivo/diretório" 0 0 )
case $? in
	1|255) PROX;;
esac
ls -i $ino > /tmp/ino.txt
dialog --backtitle "ROKUKISHI PROJECT" --exit-label Sair --title "INODE: $ino" --textbox /tmp/ino.txt 0 0 
case $? in
	0) PROX;;
	1|255) PROX;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; PROX;;
esac
}
function CONFIT(){
CONFIGT=$(dialog					\
	--stdout				\
	--backtitle "ROKUKISHI PROJECT"		\
	--ok-label Selecionar			\
	--cancel-label Voltar			\
	--menu "Escolha um Layout: "		\
	0 0 0					\
	1 "BR (Brasileiro)"			\
	2 "IT (Italiano)"	 		\
	3 "JP (Japônes)"			\
	4 "ES (Espanhol)"			\
	5 "US (Inglês)"				\
	6 "FR (Francês)" )
case $CONFIGT in
	1) BRT ;;
	2) ITT ;;
	3) JPT ;;
	4) EST ;;
	5) UST ;;
	6) FRT ;;
	*) bash /Projeto/.config/menu.sh ;;
esac
}
function BRT(){
	cp /Projeto/.config/teclado/keyboardbr /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardbr /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac

}
function ITT(){
	cp /Projeto/.config/teclado/keyboardit /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardit /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac

}
function JPT(){
	cp /Projeto/.config/teclado/keyboardjp /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardjp /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac

}
function EST(){
	cp /Projeto/.config/teclado/keyboardes /etc/default/
	rm /etc/default/keyboard
	mv /etc/default/keyboardes /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac

}
function UST(){
	cp /Projeto/.config/teclado/keyboardus /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardus /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac

}
function FRT(){
	cp /Projeto/.config/teclado/keyboardfr /etc/default/
	rm -rf /etc/default/keyboard
	mv /etc/default/keyboardfr /etc/default/keyboard
	service keyboard-setup restart
	case $? in
	0) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Teclado configurado com sucesso" 0 0; menu;;
	1|255) menu;;
	*) dialog --backtitle "ROKUKISHI PROJECT" --ok-label Continuar --msgbox "Erro $?" 0 0; menu;;
esac

}
function REINPC(){
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando em 3 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando em 2 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando em 1 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Reiniciando" 0 0
	sleep 1
	init 6
}
function DESLIGPC(){
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Seu computador sera desligado em 5 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Seu computador sera desligado em 4 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Seu computador sera desligado em 3 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Seu computador sera desligado em 2 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Seu computador sera desligado em 1 segundos..." 0 0
	sleep 1
	dialog --backtitle "ROKUKISHI PROJECT" --infobox "Desligando" 0 0
	sleep 1
	init 0
}
menu

