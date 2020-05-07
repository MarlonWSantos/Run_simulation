##!/usr/bin/env bash
#
#
#
#   run_simulation.sh - Executa o simulador do Cooja de forma automática 
#   Copyright (C) 2020 Marlon W. Santos <marlon.santos.santos@icen.ufpa.br>
#
#
#	
#   This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>
#

 #Verifica se é usuário root, pois o tunslip6 só funciona com o root
function verifyUser(){
    user=`whoami`

    if [ $user == "root" ];then
	startCoojaSimulator;
    else
	echo "Need root user to access tunslip6!"
	exit 0
    fi 
}


  #Cria um processo que inicia o arquivo .jar do cooja
function startCoojaSimulator(){
    bash -c "exec -a CoojaSimulator java -jar ./cooja_simulation.jar &"
}


  #Cria um processo que conecta o tunslip6 ao cooja
function connectTunslip(){
	 bash -c "exec -a CoojaSimulator ./tunslip6 -a 127.0.0.1 aaaa::1/64 &"
}


  #Deixe o processo parado por 30 segundos
function sleepProcess(){
    sleep 30
}


  #Finaliza o cooja e o tunslip6
function stopCoojaSimulator(){

	connectTunslip

    while [ "$close" != "exit" ]
    do
	echo "Use 'exit' to close Cooja Simulator"
	read close

	if [ "$close" == "exit" ];then
		sudo pkill -f CoojaSimulator
	fi
    done
}


  #Chamada das funções
verifyUser

sleepProcess

stopCoojaSimulator


