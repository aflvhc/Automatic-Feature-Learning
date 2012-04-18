function acc = Test(PosImgPath)
TestInternal(PosImgPath);
system('.\perf\Debug\perf.exe -info posinfo.txt -data "Haar Scripts.xml" -maxSizeDiff 4 -maxPosDiff 2' );
f = fopen('result.txt', 'r');
res = fscanf(f, '%d %d %d');
fclose(f);
acc = res(1) / (res(1)+res(2));
return;