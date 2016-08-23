http://erlang.org/doc/tutorial/c_portdriver.html

gcc -o exampledrv -fpic -shared complex.c port_driver.c -I PATH:/erts-7.3.1/include -flat_namespace -undefined suppress

mv exampledrv example_drv.so
