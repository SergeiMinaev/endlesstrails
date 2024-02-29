cd $ELT_HOME
source .env

cd manage
./bundle_js.py
./bundle_css.py
./minify.sh
cd $ELT_HOME/back
cargo build --release
cd $ELT_HOME/db
updb
