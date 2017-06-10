#!/bin/bash
function entrar(){
user="rokukishi"
pass="adglmm"
# Usuário e senha de admin.
x=3
# Chances de login
while (( $x > 0 )); do
usuario=$( dialog					\
		--stdout				\
		--title "Acesso Adiministrador"		\
		--inputbox "Usuário:" 0 0 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário para digitar o usuário de admin.
# Caso Pressione Cancel ou ESC voltará ao menu
senha=$( dialog						\
		--stdout				\
		--title "Acesso Adiministrador"		\
		--passwordbox "Senha:" 0 0 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário para digitar a senha de admin.
# Caso Pressione Cancel ou ESC voltará ao menu
	if [ $usuario == $user ] && [ $senha == $pass ]; then
		dialog --msgbox "Acesso permitido" 0 0
# Caso o usuário e senha estejam corretos irá prosseguir
# Caso não estejam, irá para o else (Se não) da estrutura
		if [ $n == "d" ]; then
			aoo=$( dialog				\
				--stdout		\
				--menu "Confirmação"	\
			0 0 0				\
			1 "Amor"			\
			2 "Ódio" )
# Caso o conteudo de n (que seria a indeficação de alterar dono ou alterar permissão
# Continuará fazendo uma seleção de confirmação
# no caso, esta parte é para o Alterar dono
				case $aoo in
					1) dialog --msgbox "Acesso permitido" 0 0; adon ;;
					2) dialog --title "Acesso Negado" --msgbox "Onde não há amor, não há acesso" 0 0 ; menu;;
					*) menu ;;
				esac
# Caso Escolha amor Irá dar acesso permitido e entrar na função para alterar o dono
# Caso Escolha ódio Dará um pequeno recado e voltará ao menu 
# Fazendo qualquer outra coisa voltará ao menu
		else
# Caso o conteudo de n não seja D, 100% de chance de ser P (Permissão)
# Continuará fazendo uma seleção de confirmação
# no caso, esta parte é para o Alterar permissões
		aoo=$( dialog				\
					--stdout		\
					--menu "Confirmação"	\
					0 0 0			\
					1 "Amor"		\
					2 "Ódio" )
				case $aoo in
					1) dialog --msgbox "Acesso permitido" 0 0; bash /Projeto/.config/gerenciadordearquivos/aper.sh ;;
					2) dialog --title "Acesso Negado" --msgbox "Onde não há amor, não há acesso" 0 0 ; menu;;
					*) menu;;
				esac
# Caso Escolha amor Irá dar acesso permitido e chamará um script expecifico para alterar permissão
# Caso Escolha ódio Dará um pequeno recado e voltará ao menu
# Fazendo qualquer outra coisa voltará ao menu
		fi
	else
		dialog --msgbox "Acesso negado" 0 0
		let x=($x-1)
# Caso Login esteja incorreto, Dará acesso negado
# Subitrairá 1 na contagem de chances para fazer login
	fi
done
dialog --msgbox "Sem acesso superior" 0 0
menu
# Caso Exceda as tentativas de login, Dará Acesso negado e voltará ao menu
}
function menu(){
opcao=$( dialog						\
	--stdout					\
	--title "Gerenciador de Arquivo"		\
	--menu "O que deseja fazer?"	 		\
	0 0 0						\
	1 "Criar Arquivo"				\
	2 "Apagar arquivo"				\
	3 "criar diretório"				\
	4 "apagar diretório"				\
	5 "Mostrar conteúdo de arquivo"			\
	6 "listar diretório"				\
	7 "Manual Linux"				\
	8 "Entrar no diretório"				\
	9 "Copiar arquivo/diretório"			\
	10 "Mover arquivo/diretório"			\
	11 "Renomear arquivo/diretório"			\
	12 "Alterar dono"				\
	13 "Alterar permissões"				\
	14 "Agrupar arquivos/diretórios"		\
	15 "Desagrupar arquivos/diretórios"		\
	16 "Compactar Arquivo/Diretório"		\
	17 "Descompactar Arquivo/Diretório"		\
	18 "Editar arquivo"				\
	19 "Voltar um diretório"			\
	20 "Ir para a raiz"				\
	21 "Voltar para o menu" )
case $opcao in
	1) carq ;;
	2) aarq ;;
	3) cdir ;;
	4) adir ;;
	5) vera ;;
	6) bash /Projeto/.config/gerenciadordearquivos/list.sh ;;
	7) manual ;;
	8) edir ;;
	9) copa ;;
	10) mova ;;
	11) rename ;;
	12) n="d"; entrar ;;
	13) n="p"; entrar ;;
	14) x=0 ; aaed;;
	15) daed ;;
	16) comp ;;
	17) desc ;;
	18) edit ;;
	19) cd ..; bash /Projeto/.config/menu.sh;;
	19) cd /; bash /Projeto/.config/menu.sh;;
	20) bash /Projeto/.config/menu.sh ;;
	*) bash /Projeto/.config/menu.sh;;
esac
# Menu onde esta disponivel algumas funções, algumas chamando scripts separadamente, outras chamando funções do próorio script
# Caso não escolha nenhuma das opções, como Cancel e ESC, chamará novamente o menu
}
function carq(){
arq=$( dialog						\
	--stdout					\
	--title "Criar arquivo"				\
	--inputbox "Digite o nome/local do arquivo (sem espaço, caso seja preciso, utilize aspas no nome do arquivo):"				\
	10 60 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário Digitar o nome do arquivo a ser criado, armazenando em sua variável arq
# Case pressione Cancel ou ESC, voltará ao menu
cat $arq
# Mostrará o conteúdo do arquivo
# Comando necessário para ver se o arquivo ja existe antes de criá-lo
case $? in
	0) dialog --msgbox "O arquivo ja existe" 0 0; menu;;
	1) > $arq; volta=$?;;
	*) dialog --title "Erro $?" --msgbox "Não foi possivel criar o arquivo" 0 0; menu;;
esac
# Se retornar 0 saberemos que o arquivos ja é existente e avisará o usuário, voltando para o menu
# Se retornar 1 o arquivo não existe, assim criamos o arquivo e salvamos o retorno
# Caso dê outro retorno, nos avisará o erro ocorrido e voltará ao menu
case $volta in
	0) dialog --msgbox "O arquivo foi criado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel criar o arquivo" 0 0; menu;;
	*) dialgo --title "Erro $?" --msgbox "Não foi possivel criar o arquivo" 0 0; menu;;
esac
# Caso o retorno seja 0 é avisado que o arquivo foi criado com sucesso, voltando ao menu
# Caso 1, será avisada sua falha na criação, voltando ao menu
# Case seja um retorno desconhecido, avisará o erro ocorrido, voltando ao menu
}
function aarq(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar arquivo"			\
	--fselect /					\
	10 70 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário Digitar o nome do arquivo a ser apagado, armazenando em sua variável arq
# Case pressione Cancel ou ESC, voltará ao menu
cat $arq
# Mostrará o conteúdo do arquivo
# Comando necessário para ver se o arquivo existe antes de tentar apagá-lo
case $? in
	1) dialog --msgbox "O arquivo não existe" 0 0; menu;;
	0) rm -rf $arq; volta=$?;;
	*) dialog --title "Erro $?" --msgbox "Não foi possivel apagar o arquivo" 0 0; menu;;
esac
# Se retornar 1 saberemos que o arquivo é inexistente e avisará o usuário, voltando para o menu
# Se retornar 0 o arquivo existe, assim podemos continuar o processo, apagando o arquivo e salvamos o retorno
# Caso dê outro retorno, nos avisará o erro ocorrido e voltará ao menu
case $volta in
	0) dialog --msgbox "O arquivo foi apagado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel apagado o arquivo" 0 0; menu;;
	*) dialgo --title "Erro $?" --msgbox "Não foi possivel apagar o arquivo" 0 0; menu;;
esac
# Caso o retorno seja 0 é avisado que o arquivo foi apagado com sucesso, voltando ao menu
# Caso 1, será avisada sua falha ao apagar, voltando ao menu
# Case seja um retorno desconhecido, avisará o erro ocorrido, voltando ao menu
}
function cdir(){
arq=$( dialog						\
	--stdout					\
	--title "Criar diretório"			\
	--inputbox "Digite o nome/local do diretório (sem espaço, caso seja preciso, utilize aspas no nome do diretório):"	\
	10 60 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário Digitar o nome do diretório a ser criado, armazenando em sua variável arq
# Case pressione Cancel ou ESC, voltará ao menu
cd $arq
# Entrará no diretório
# Comando necessário para ver se o diretório ja existe antes de criá-lo
case $? in
	0) dialog --msgbox "O diretório ja existe" 0 0; cd /Projeto; menu;;
	1) mkdir $arq; volta=$?;;
	*) dialog --msgbox "Não foi possivel criar o diretório" 0 0; menu;;
esac
# Se retornar 0 saberemos que o diretório ja é existente e avisará o usuário, voltará para a pasta do projeto, voltando para o menu
# Se retornar 1 o diretório não existe, assim criamos o diretório e salvamos o retorno
# Caso dê outro retorno, nos avisará o erro ocorrido e voltará ao menu
case $volta in
	0) dialog --msgbox "O diretório foi criado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel apagar o diretório" 0 0; menu;;
	*) dialgo --title "Erro $?" --msgbox "Não foi possivel apagar o diretório" 0 0; menu;;
esac
# Caso o retorno seja 0 é avisado que o diretório foi criado com sucesso, voltando ao menu
# Caso 1, será avisada sua falha na criação, voltando ao menu
# Case seja um retorno desconhecido, avisará o erro ocorrido, voltando ao menu
}
function adir(){
arq=$( dialog						\
	--stdout					\
	--title "Apagar diretório"			\
	--fselect /					\
	10 70 )
case $? in
	1|255) menu;;
esac
# Pede para o usuário Digitar o nome do diretório a ser apagado, armazenando em sua variável arq
# Case pressione Cancel ou ESC, voltará ao menu
cd $arq
# Entrará no diretório
# Comando necessário para ver se o diretório existe antes de tentar apagá-lo
case $? in
	1) dialog --msgbox "O diretório não existe" 0 0; menu;;
	0) cd -; rmdir $arq;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Se retornar 1 saberemos que o diretório é inexistente e avisará o usuário, voltando para o menu
# Se retornar 0 o diretório existe, voltando para o diretório anterior acessado (Provavelmente /Projeto)
# Assim podemos continuar o processo, apagando o arquivo e salvamos o retorno
# Caso dê outro retorno, nos avisará o erro ocorrido e voltará ao menu
if [ $? == "0" ]; then
	dialog --msgbox "O diretório foi apagado com sucesso" 0 0
	menu
# Se o retorno, após tentar apagar o diretório for 0
# Avisará que foi apagado com sucesso e voltará ao menu
elif [ $? == "1" ]; then
	dialog --title "Erro" --msgbox "Diretório não está vazio" 0 0
	dialog --yesno "Deseja o apagar mesmo assim?" 0 0
case $? in
	0) rm -rf $arq; volta=$?;;
	1) menu;;
	*) menu;;
esac
case $volta in
	0) dialog --msgbox "O diretório foi apagado com sucesso" 0 0; menu;;
	*) dialog --msgbox "Não foi possivel apagar" 0 0; menu;;
esac
# Caso o retorno seja 1, Avisará que não é possivel apagar pois tal diretório não esta vazio
# Perguntando ao usuário se deseja apagar mesmo assim, forçando-o
# Caso o retorno seja 0, avisará o sucesso, caso 1, avisará da impossibilidade de apagar
# Voltando para o menu
else
	dialog --title "Erro $?" --msgbox "Não foi possivel apagar o arquivo" 0 0
	menu
# Caso o retorno seja desconhecido, Mostrará o erro ocorrido e voltará ao menu
fi
}
function vera(){
arq=$( dialog						\
		--stdout				\
		--title "Mostrar conteúdo de arquivo:"	\
		--fselect / 10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo para visualizar, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
cat $arq > /tmp/vera.txt
# Mandará o conteudo do arquivo para um arquivo temporário
case $? in
	0) dialog --title "$arq" --textbox /tmp/vera.txt 0 0; menu;;
	1) dialog --msgbox "Arquivo não existe ou é um diretório" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, mostrará via dialog seu conteúdo pelo arquivo temporário
# Case 1 avisará a impossibilidade de mostrar, visto que não existe ou é um diretório
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function manual(){
manu=$( dialog						\
		--stdout				\
		--title "Manual Linux"			\
		--inputbox "Nome do comando linux:" 8 50 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do comando para ver o manual, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
man $manu > /tmp/manual.txt
# Mandará o manual do comando para um arquivo temporário
case $? in
	0) dialog --title "$manu" --textbox /tmp/manual.txt 0 0 ;menu;;
	1) dialog --msgbox "Comando não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, mostrará via dialog seu conteúdo pelo arquivo temporário
# Caso 1 avisará a impossibilidade de mostrar, visto que não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function edir(){
arq=$( dialog 						\
		--stdout				\
		--title "Entrar no diretório"		\
		--fselect / 				\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do diretório para entrar, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
cd $arq
# Entrará no diretório
case $? in
	0) bash /Projeto/.config/menu.sh;;
	1) dialog --msgbox "Diretório não encontrado, tente novamente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, Entrará no menu expecifico para um diretório diferente
# Caso 1 avisará a impossibilidade de mostrar, visto que não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function copa(){
arq=$( dialog						\
		--stdout				\
		--menu "Copiar:"			\
		0 0 0					\
		1 "Arquivo"				\
		2 "Diretório"				\
		3 "Voltar" )
case $arq in
	1) car;;
	2) cdr;;
	3) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Neste menu se escolhe para copiar entre arquivo ou diretório
# Onde cada uma chama uma função expecifica
# Onde a terceira opção volta ao menu
# Caso Faça qualquer outra coisa, Mostrará o erro e voltará ao menu
}
function car(){
origem=$( dialog 					\
		--stdout				\
		--title "Origem"		\
		--fselect /				\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo a ser copiado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
destino=$( dialog 					\
		--stdout				\
		--title "Destino"		\
		--fselect /			\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o destino para onde o arquivo será copiado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
cp $origem $destino
# Copiará o arquivo
case $? in
	0) dialog --msgbox "Arquivo copiado com sucesso" 0 0 ; menu;;
	1) dialgo --msgbox "Arquivo ou destino não encontrados" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
# Caso o retorno seja 0, via dialog, avisará o sucesso ao copiar
# Caso 1 avisará a impossibilidade de copiar, visto que o arquivo ou destino não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function cdr(){
origem=$( dialog 					\
		--stdout				\
		--title "Origem"			\
		--fselect /				\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do diretório a ser copiado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
destino=$( dialog 					\
		--stdout				\
		--title "Destino"			\
		--fselect /				\
		10 70 )
case $? in
	1|255) menu;;
# Pedirá ao usuário o destino para onde o diretório será copiado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
esac
cp -r $origem $destino
# Copiará o diretório recursivamente para o destino selecionado
case $? in
	0) dialog --msgbox "Diretório copiado com sucesso" 0 0 ; menu;;
	1) dialgo --msgbox "Diretório ou destino não encontrados" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
# Caso o retorno seja 0, via dialog, avisará o sucesso ao copiar
# Caso 1 avisará a impossibilidade de copiar, visto que o diretório ou destino não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function mova(){
origem=$( dialog 						\
		--stdout				\
		--title "Origem"			\
		--fselect /				\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo ou diretório a ser movido, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
destino=$( dialog 					\
		--stdout				\
		--title "Destino"		\
		--fselect /				\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o destino para onde o arquivo ou diretório será movido, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
mv $origem $destino
# moverá o arquivo ou diretório ao destino selecionado
case $? in
	0) dialog --msgbox "Arquivo/diretório movido com sucesso" 0 0 ; menu;;
	1) dialog --msgbox "Arquivo/diretório ou destino não encontrado" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0 ; menu;;
esac
# Caso o retorno seja 0, via dialog, avisará o sucesso ao mover
# Caso 1 avisará a impossibilidade de mover, visto que o arquivo ou diretório ou destino não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function rename(){
arq=$( dialog 						\
		--stdout				\
		--title "Renomear"			\
		--inputbox "Nome atual (sem espaço, caso seja preciso, utilize aspas no nome do arquivo ou diretório):" 10 60 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome atual do arquivo ou diretório a ser renomeado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
arq2=$( dialog 						\
		--stdout				\
		--title "Renomear"			\
		--inputbox "Alterar para:" 8 50 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo ou diretório que deseja, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
mv $arq $arq2
# Renomeará para o nome escolhido
case $? in
	0) dialog --msgbox "Renomeado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Arquivo ou diretório não existente" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, via dialog, avisará o sucesso ao renomear
# Caso 1 avisará a impossibilidade de renomear, visto que o arquivo ou diretório ou destino não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function adon(){
arq=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--fselect /					\
	10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo ou diretório a ser alterado o dono, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
arq2=$( dialog						\
	--stdout					\
	--title "Alterar dono"				\
	--inputbox "Digite o nome do dono:"		\
	8 50 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do novo dono do arquivo ou diretório, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
chown $arq2 $arq
# Alterando assim o dono
case $? in
	0) dialog --msgbox "Dono alterado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel alterar o dono" 0 0; adon;;
	*) dialog --msgbox "erro $?" 0 0; adon;;
esac
# Caso o retorno seja 0, via dialog, avisará o sucesso ao alterar o dono
# Caso 1 avisará a impossibilidade de alterar, visto que o arquivo ou diretório ou dono não existe
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu, assim como nos retornos anteriores
}
function aaed(){
name=$( dialog						\
		--stdout				\
		--title "Agrupar arquivos/diretórios"	\
		--inputbox "Nome do arquivo final (sem espaço, caso seja preciso, utilize aspas no nome do arquivo):"	\
		10 60 )
case $? in
	1|255) menu;;
esac
# Pedirá para o usuário digitar o nome do arquivo final, a qual todos os arquivos e diretórios serão agrupados
# Caso Pressione Cancel ou ESC voltará ao menu
arq=$( dialog 						\
		--stdout				\
		--title "Agrupar arquivos ou diretórios"	\
		--menu "Adicionar/Agrupar"		\
		0 0 0					\
		1 "Adicionar arquivo ou diretório"		\
		2 "Agrupar"				\
		3 "Voltar" )
case $arq in
	1) nome[$x]=$( dialog --stdout --title "Adicionar arquivo ou diretório" --inputbox "Nome (sem espaço, caso seja preciso, utilize aspas no nome do arquivo ou diretório):" 10 60 ); let x=($x+1); aaed;;
	2) tar -cvf $name.tar ${nome[@]} > /tmp/agrupar.txt; dialog --textbox /tmp/agrupar.txt 0 0; menu;;
	3) menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Para agrupar arquivos ou diretórios, é necesário escolher a opção 1 para adicionar tais
# Guardando todos os nomes em uma váriavel array nome
# Ao selecionar a opção 2, é feito o agrupamento utilizando o comando tar, selecionando TODOS os nomes da variável
# Mandando assim para um arquivo temporário o nome de todos os arquivos agrupados
# Podendo optar também por voltar ao menu, escolhendo a opção 3
# Caso aja um retorno desconhecido, avisará do erro ocorrido e voltará ao menu
}
function daed(){
arq=$( dialog 						\
		--stdout				\
		--title "Nome do arquivo"		\
		--fselect /				\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo ser desagrupado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
tar -xvf $arq.tar > /tmp/desagrupar.txt
# Utilizando o comando tar para desagrupar
# mandando a saida para um arquivo temporário
case $? in
	0) dialog --textbox /tmp/desagrupar.txt 0 0; dialog --msgbox "Extraido com sucesso" 0 0; menu;;
	1) dialog --msgbox "Impossivel extrair arquivo, arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno do desagrupamento seja 0 Mostrará os arquivos todos os arquivos/diretório que foram separados
# Caso seja 1, avisará da impossibilidade de desagrupar o arquivo pela sua inexistencia
# Caso seja retorno desconhecido, avisará do erro ocorrido e voltará ao menu assim como os outros retornos
}
function comp(){
arq=$( dialog							\
		--stdout					\
		--title "Compactar arquivo/diretório"		\
		--fselect /					\
		10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo ou diretório ser compactado, e salvará o nome em sua variável arq
# Caso pressione Calcel ou ESC, voltará ao menu
cd $arq
# Entrará no nome proposto pelo usuário
# Verificando se é um arquivo ou diretório
case $? in
	0) cd -; arq2=$( dialog					\
				--stdout			\
				--title "Compactar diretório"	\
				--inputbox "Nome do arquivo final:" \
				8 50 ); tar -czf $arq2.tar.gz $arq; num2=$?;;
	1) gzip $arq; num2=$?;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, é um diretório. Pedindo pro usuário o nome do arquivo final
# Compactando junto com tar e gzip, comando necessário para compactar diretório, salvando seu retorno
# Caso seja 1 compatará normalmente, salvando o retorno
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu
case $num2 in
	0) dialog --msgbox "Compactado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel compactar" 0 0; menu;;
	*) dialog --msgbox "erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, mostrará o sucesso ao compactar
# Caso seja 1, mostrará a impossibilidade ao compactar, visto que possivelmente o arquivo não exista
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function desc(){
arq=$( dialog						\
		--stdout				\
		--menu "Descompactar:"			\
		0 0 0					\
		1 "Arquivo"					\
		2 "Diretório"					\
		3 "Voltar" )
case $arq in
	1) nome=$( dialog				\
			--stdout			\
			--title "Descompactar"		\
			--fselect / 			 \
			10 70 ); gunzip $nome; saida=$?;;
	2) nome=$( dialog				\
			--stdout			\
			--title "Descompactar"		\
			--fselect /			 \
			10 70 ); tar -zxvf $nome; saida=$?;;
	3) menu;;
	*) menu;;
esac
# Opções que diferenciam o comando usado para diretório e arquivo
# Caso seja um Arquivo, descompactará somente com gunzip, salvando seu retorno
# Caso seja diretório descompactará, da mesma forma compactado, com tar, salvando seu retorno
# Optando também por voltar ao menu ao escolher a opção 3
# Caso faça qualquer outra coisa, voltará ao menu
case $saida in
	0) dialog --msgbox "Descompactado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Não foi possivel descompactar" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, mostrará o sucesso ao descompactar
# Caso seja 1, mostrará a impossibilidade ao descompactar, visto que possivelmente o arquivo não exista
# Caso seja retorno desconhecido, mostrará o erro ocorrido e voltará ao menu assim como os outros retornos
}
function edit(){
opcao=$( dialog 						\
		--stdout					\
		--title "Arquivo/local"				\
		--fselect / 10 70 )
case $? in
	1|255) menu;;
esac
# Pedirá ao usuário o nome do arquivo a ser editado
# Caso pressione Cancel ou ESC voltará ao menu
editor=$( dialog						\
		--stdout					\
		--title "Editor"				\
		--menu "Escolha o editor de texto:"		\
		0 0 0						\
		1 "NANO"					\
		2 "VI"						\
		3 "Voltar" )
case $editor in
	1) nano $opcao; volta=$?;;
	2) vi $opcao; volta=$?;;
	3) menu;;
	*) menu;;
esac
# O usuário tem a opção de escolher entre dois editores de texto
# NANO ou VI
# Caso seja NANO, utilizara tal comando para abrir o arquivo, salvando seu retorno
# Caso seja VI, utilizara tal comando para abrir o arquivo, salvando seu retorno
# Podendo voltar o menu ao escolher a opção 3 ou fazendo qualquer outra coisa
case $volta in
	0) dialog --msgbox "Editado com sucesso" 0 0; menu;;
	1) dialog --msgbox "Arquivo não existe" 0 0; menu;;
	*) dialog --msgbox "Erro $?" 0 0; menu;;
esac
# Caso o retorno seja 0, após a edição do arquivo, avisará que foi editado com sucesso
# Caso 1 O arquivo nao existe
# Caso o retorno seja desconhecido, voltará diretamente ao menu assim como os outros retornos
}
menu
