cd .\tests\
for %%x in (*.zx5) do del "%%x" 
for %%x in (*.bin) do ..\tools\zx5.exe "%%x" "%%~nx.bin.zx5"

cd ..
cmd /c "BeebAsm.exe -v -i zx5_test.s.asm -do zx5_test.ssd -opt 3"