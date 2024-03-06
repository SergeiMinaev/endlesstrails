#!/bin/bash

cd $ELT_HOME
source .env
cd ./front/ext

declare -a deps_dirs=("/work/fr9" "/work/front_admin" "/work/front_common")
declare -a deps_repos=(
	"git@github.com:SergeiMinaev/fr9.git"
	"git@github.com:SergeiMinaev/front_admin.git"
	"git@github.com:SergeiMinaev/front_common.git"
)

if [[ $MODE != "prod" ]]; then
	echo "Mode is 'dev'. Linking to /work."
	for path in "${deps_dirs[@]}"; do
		#echo "$path";
		dir=$(echo $path | tr '/' '\n' | tail -n 1)
		if [[ ! -d ${dir} ]]; then
			echo "${path} not exists. Linking."
			ln -sn $path
		else
			echo "${path} exists."
		fi
	done
else
	echo "Mode is 'prod'. Updating deps from git."
	for path in "${deps_repos[@]}"; do
		#echo "$path";
		dir=$(echo $path | tr '/' '\n' | tail -n 1)
		if [[ ! -d ${dir} ]]; then
			echo "${path} not exists. Cloning from git."
			git clone $path
		else
			echo "${path} exists. Pulling from git."
			cd ${dir}
			git pull
		fi
	done
fi

cd $ELT_HOME/front
if [[ ! -d ./js/admin ]]; then
	ln -sn $ELT_HOME/front/ext/front_admin/js/admin ./js/admin
fi
if [[ ! -d ./style/admin ]]; then
	ln -sn $ELT_HOME/front/ext/front_admin/style/admin ./style/admin
fi
if [[ ! -d ./templates/admin ]]; then
	ln -sn $ELT_HOME/front/ext/front_admin/templates/admin ./templates/admin
fi

if [[ ! -d ./js/common ]]; then
	ln -sn $ELT_HOME/front/ext/front_common ./js/common
fi

if [[ ! -d ./js/fr9 ]]; then
	ln -sn $ELT_HOME/front/ext/fr9 ./js/fr9
fi
