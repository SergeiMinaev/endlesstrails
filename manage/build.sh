cd $ELT_HOME
source .env

source .venv/bin/activate
pdm sync

cd manage
./sync_deps.sh
#./bundle_js.py
./bundle_js.sh
./bundle_css.sh
#./minify.sh
cd $ELT_HOME/back
cargo update
cargo build --release
cd $ELT_HOME/db
updb
