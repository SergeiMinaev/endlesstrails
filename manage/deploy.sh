cd $ELT_HOME/manage
./sync_deps.sh
./build.sh
sudo /etc/init.d/elt restart
