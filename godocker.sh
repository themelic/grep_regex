#!/bin/bash
# -*- coding: utf-8 -*-
##############################################################################
#
#    Melih Melik SÖNMEZ
#    Copyright (C) 2023-TODAY melic.com
#    you can modify it under the terms of the GNU LESSER
#    GENERAL PUBLIC LICENSE (AGPL v3), Version 3.
#    This script is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU LESSER GENERAL PUBLIC LICENSE (AGPL v3) for more details.
#
#    You should have received a copy of the GNU LESSER GENERAL PUBLIC LICENSE
#    GENERAL PUBLIC LICENSE (AGPL v3) along with this script.
#    If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

##Script requires 2 entries ; first one is for the action command  and second and third ones are paramaters required for action

ACTION=$1
PARAMETER1=$2


case "${ACTION}" in
##LIST OF DOCKER CONTAINERS
list)
              ## [ -z "${PARAMETER1}" ]  checks if parameter is null or not and if it is null it returns TRUE; if you need false you should use it like this [ ! -z "${PARAMETER1}" ] 
                if [ -z "${PARAMETER1}" ] ; then
                        docker ps
                else
                        docker ps |grep ${PARAMETER1}
                fi
;;


##TAKE 5 LETTERS OF CONTAINERID
code5)


                echo ".... d o i n g"
                docker ps |grep ${PARAMETER1} | grep -oP '([0-9a-f]+)' | head -n 1 | cut -c 1-5
;;

##TAKE 5 LETTERS OF CONTAINERID-POSTGRE
codepostgre)

                echo ".... d o i n g"
                docker ps |grep ${PARAMETER1}-postgre | grep -oP '([0-9a-f]+)' | head -n 1 | cut -c 1-5
;;


##LIST LOGS FOR CONTAINER
takelog)
        clear
        echo ".... d o i n g"
        docker logs -f -n 200 $(docker ps |grep ${PARAMETER1} | grep -oP '([0-9a-f]+)' | head -n 1 | cut -c 1-5)
;;

##CONNECT CONTAINER POSTGRE
connectpsql)

        read -p "This script will restart service of tenant's docker.
           Your command is "${ACTION}" and the parameters of the command are : [${PARAMETER1}]
           Are you sure you want to proceed? (y/n) " confirm

           if [[ $confirm != [yY] ]]; then
              echo "Aborting script."
              exit 1
           else
 ##           clear
                echo ".... d o i n g"
                docker exec -ti $(docker ps |grep ${PARAMETER1}-postgre | grep -oP '([0-9a-f]+)' | head -n 1 | cut -c 1-5) bash
           fi
;;

##CONNECT CONTAINER POSTGRE
restart)
    ## SOURCE="/path/to/your/addons"
    ## DESTINATION="/path/to/your/tenants/directory"

        read -p "This script will restart service of tenant's docker.
           Your command is "${ACTION}" and the parameters of the command are : [${PARAMETER1}]
           Are you sure you want to proceed? (y/n) " confirm

           if [[ $confirm != [yY] ]]; then
              echo "Aborting script."
              exit 1
           else
 ##           clear
                echo ".... d o i n g"
                docker service update --force ${PARAMETER1}
           fi
;;


## No action is used so this is the end of the script
*)
    echo "Opps ! You mistype it ; you have to add missing action."
    echo "Usage: dockcont.sh command <containername>"
    echo "possible commands : list | code5 | codepostgre | takelog | connectpsql | restart"
;;
esac
