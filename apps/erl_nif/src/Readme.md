http://erldocs.com/18.3/erts/erl_nif.html

gcc -fPIC -shared -o niftest.so niftest.c -I $ERL_ROOT/usr/include/ -I ERTS_PATH/include -flat_namespace -undefined suppress