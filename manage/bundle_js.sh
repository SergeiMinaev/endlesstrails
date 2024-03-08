cd $ELT_HOME
esbuild --preserve-symlinks --bundle --minify front/js/core/core.js > static/js/core.min.js
esbuild --preserve-symlinks --bundle --minify front/js/admin/admin.js > static/js/admin.min.js
