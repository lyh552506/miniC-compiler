    .file  "file"
    .attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
    .attribute unaligned_access, 0
    .attribute stack_align, 16
    .text
    .align  1
    .globl  func
    .type  func, @function
func:
.LBB0:
	addi sp, sp, -336
	sd ra, 328(sp)
	sd s0, 320(sp)
	addi s0, sp, 336
	li t0, -4096
	addiw t0, t0, -2048
	add sp, sp, t0
	lw t2, 0(s0)
	lw t2, 4(s0)
	addiw t0, s0, -2047
	sd t2, -265(t0)
	lw t2, 8(s0)
	sd t2, -1648(s0)
	lw t2, 12(s0)
	sd t2, -1640(s0)
	lw t2, 16(s0)
	sd t2, -1632(s0)
	lw t2, 20(s0)
	lw t2, 24(s0)
	sd t2, -1624(s0)
	lw t2, 28(s0)
	sd t2, -1616(s0)
	lw t2, 32(s0)
	lw t2, 36(s0)
	lw t2, 40(s0)
	lw t2, 44(s0)
	lw t2, 48(s0)
	sd t2, -1608(s0)
	lw t2, 52(s0)
	lw t2, 56(s0)
	sd t2, -1600(s0)
	lw t2, 60(s0)
	sd t2, -1592(s0)
	lw t2, 64(s0)
	sd t2, -1504(s0)
	lw t2, 68(s0)
	sd t2, -1576(s0)
	lw t2, 72(s0)
	lw t2, 76(s0)
	sd t2, -1568(s0)
	lw t2, 80(s0)
	lw t2, 84(s0)
	sd t2, -1560(s0)
	lw t2, 88(s0)
	sd t2, -1552(s0)
	lw t2, 92(s0)
	sd t2, -1544(s0)
	lw t2, 96(s0)
	lw t2, 100(s0)
	lw t2, 104(s0)
	lw t2, 108(s0)
	lw t2, 112(s0)
	lw t2, 116(s0)
	lw t2, 120(s0)
	sd t2, -1536(s0)
	lw t2, 124(s0)
	sd t2, -1528(s0)
	lw t2, 128(s0)
	lw t2, 132(s0)
	sd t2, -1520(s0)
	lw t2, 136(s0)
	lw t2, 140(s0)
	sd t2, -1512(s0)
	lw t2, 144(s0)
	lw t2, 148(s0)
	sd t2, -1584(s0)
	lw t2, 152(s0)
	lw t2, 156(s0)
	sd t2, -1792(s0)
	lw t2, 160(s0)
	lw t2, 164(s0)
	sd t2, -1784(s0)
	lw t2, 168(s0)
	lw t2, 172(s0)
	sd t2, -1776(s0)
	lw s11, 176(s0)
	lw t2, 180(s0)
	lw t2, 184(s0)
	lw t2, 188(s0)
	lw t2, 192(s0)
	lw t2, 196(s0)
	lw t2, 200(s0)
	sd t2, -1768(s0)
	lw t2, 204(s0)
	lw t2, 208(s0)
	sd t2, -1760(s0)
	lw t2, 212(s0)
	sd t2, -1752(s0)
	lw t2, 216(s0)
	lw t2, 220(s0)
	sd t2, -1744(s0)
	lw t2, 224(s0)
	sd t2, -1736(s0)
	lw t2, 228(s0)
	lw t2, 232(s0)
	lw t2, 236(s0)
	sd t2, -1656(s0)
	lw t2, 240(s0)
	sd t2, -1720(s0)
	lw t2, 244(s0)
	sd t2, -1712(s0)
	lw t2, 248(s0)
	sd t2, -1704(s0)
	lw t2, 252(s0)
	sd t2, -1696(s0)
	lw t2, 256(s0)
	lw t2, 260(s0)
	lw t2, 264(s0)
	lw t2, 268(s0)
	lw t2, 272(s0)
	sd t2, -1688(s0)
	lw t2, 276(s0)
	lw t2, 280(s0)
	sd t2, -1680(s0)
	lw t2, 284(s0)
	lw t2, 288(s0)
	lw t2, 292(s0)
	lw t2, 296(s0)
	sd t2, -1672(s0)
	lw t2, 300(s0)
	sd t2, -1664(s0)
	lw t2, 304(s0)
	lw t2, 308(s0)
	lw t2, 312(s0)
	sd t2, -1432(s0)
	lw t2, 316(s0)
	lw t2, 320(s0)
	sd t2, -1352(s0)
	lw t2, 324(s0)
	sd t2, -1344(s0)
	lw t2, 328(s0)
	sd t2, -1336(s0)
	lw t2, 332(s0)
	sd t2, -1328(s0)
	lw t2, 336(s0)
	sd t2, -1320(s0)
	lw t2, 340(s0)
	sd t2, -1312(s0)
	lw t2, 344(s0)
	lw t2, 348(s0)
	lw t2, 352(s0)
	lw t2, 356(s0)
	sd t2, -1304(s0)
	lw t2, 360(s0)
	lw t2, 364(s0)
	sd t2, -1296(s0)
	lw t2, 368(s0)
	sd t2, -1208(s0)
	lw t2, 372(s0)
	lw t2, 376(s0)
	lw t2, 380(s0)
	lw t2, 384(s0)
	lw t2, 388(s0)
	lw t2, 392(s0)
	sd t2, -1280(s0)
	lw t2, 396(s0)
	sd t2, -1272(s0)
	lw t2, 400(s0)
	sd t2, -1264(s0)
	lw t2, 404(s0)
	lw t2, 408(s0)
	lw t2, 412(s0)
	sd t2, -1256(s0)
	lw t2, 416(s0)
	sd t2, -1248(s0)
	lw t2, 420(s0)
	lw t2, 424(s0)
	lw t2, 428(s0)
	sd t2, -1240(s0)
	lw t2, 432(s0)
	sd t2, -1232(s0)
	lw t2, 436(s0)
	sd t2, -1224(s0)
	lw t2, 440(s0)
	lw t2, 444(s0)
	lw t2, 448(s0)
	lw t2, 452(s0)
	lw t2, 456(s0)
	lw t2, 460(s0)
	sd t2, -1216(s0)
	lw t2, 464(s0)
	sd t2, -1288(s0)
	lw t2, 468(s0)
	lw t2, 472(s0)
	lw t2, 476(s0)
	sd t2, -1496(s0)
	lw t2, 480(s0)
	lw t2, 484(s0)
	lw t2, 488(s0)
	sd t2, -1488(s0)
	lw t2, 492(s0)
	lw t2, 496(s0)
	sd t2, -1480(s0)
	lw t2, 500(s0)
	lw t2, 504(s0)
	lw t2, 508(s0)
	sd t2, -1472(s0)
	lw t2, 512(s0)
	sd t2, -1464(s0)
	lw t2, 516(s0)
	lw t2, 520(s0)
	lw t2, 524(s0)
	sd t2, -1456(s0)
	lw t2, 528(s0)
	lw t2, 532(s0)
	sd t2, -1448(s0)
	lw t2, 536(s0)
	lw t2, 540(s0)
	sd t2, -1440(s0)
	lw t2, 544(s0)
	sd t2, -1360(s0)
	lw t2, 548(s0)
	sd t2, -1424(s0)
	lw t2, 552(s0)
	lw t2, 556(s0)
	lw t2, 560(s0)
	lw t2, 564(s0)
	lw t2, 568(s0)
	lw t2, 572(s0)
	sd t2, -1416(s0)
	lw t2, 576(s0)
	lw t2, 580(s0)
	sd t2, -1408(s0)
	lw t2, 584(s0)
	lw t2, 588(s0)
	sd t2, -1400(s0)
	lw t2, 592(s0)
	lw t2, 596(s0)
	lw t2, 600(s0)
	sd t2, -1392(s0)
	lw t2, 604(s0)
	sd t2, -1384(s0)
	lw t2, 608(s0)
	lw t2, 612(s0)
	sd t2, -1376(s0)
	lw t2, 616(s0)
	sd t2, -1368(s0)
	lw t2, 620(s0)
	sd t2, -1728(s0)
	lw t2, 624(s0)
	lw t2, 628(s0)
	lw t2, 632(s0)
	addiw t0, s0, -2047
	sd t2, -185(t0)
	lw t2, 636(s0)
	lw t2, 640(s0)
	lw t2, 644(s0)
	lw t2, 648(s0)
	addiw t0, s0, -2047
	sd t2, -177(t0)
	lw t2, 652(s0)
	addiw t0, s0, -2047
	sd t2, -169(t0)
	lw t2, 656(s0)
	addiw t0, s0, -2047
	sd t2, -161(t0)
	lw t2, 660(s0)
	lw t2, 664(s0)
	lw t2, 668(s0)
	lw t2, 672(s0)
	lw t2, 676(s0)
	addiw t0, s0, -2047
	sd t2, -153(t0)
	lw t2, 680(s0)
	lw t2, 684(s0)
	lw t2, 688(s0)
	lw t2, 692(s0)
	lw t2, 696(s0)
	addiw t0, s0, -2047
	sd t2, -145(t0)
	lw t2, 700(s0)
	addiw t0, s0, -2047
	sd t2, -137(t0)
	lw t2, 704(s0)
	addiw t0, s0, -2047
	sd t2, -129(t0)
	lw t2, 708(s0)
	addiw t0, s0, -2047
	sd t2, -49(t0)
	lw t2, 712(s0)
	lw t2, 716(s0)
	addiw t0, s0, -2047
	sd t2, -113(t0)
	lw t2, 720(s0)
	addiw t0, s0, -2047
	sd t2, -105(t0)
	lw t2, 724(s0)
	addiw t0, s0, -2047
	sd t2, -97(t0)
	lw t2, 728(s0)
	lw t2, 732(s0)
	lw t2, 736(s0)
	lw t2, 740(s0)
	lw t2, 744(s0)
	lw t2, 748(s0)
	addiw t0, s0, -2047
	sd t2, -89(t0)
	lw t2, 752(s0)
	lw t2, 756(s0)
	lw t2, 760(s0)
	addiw t0, s0, -2047
	sd t2, -81(t0)
	lw t2, 764(s0)
	lw t2, 768(s0)
	addiw t0, s0, -2047
	sd t2, -73(t0)
	lw t2, 772(s0)
	addiw t0, s0, -2047
	sd t2, -65(t0)
	lw t2, 776(s0)
	lw t2, 780(s0)
	lw t2, 784(s0)
	addiw t0, s0, -2047
	sd t2, -57(t0)
	lw t2, 788(s0)
	addiw t0, s0, -2047
	sd t2, -121(t0)
	lw t2, 792(s0)
	addiw t0, s0, -2047
	sd t2, -329(t0)
	lw t2, 796(s0)
	lw t2, 800(s0)
	addiw t0, s0, -2047
	sd t2, -321(t0)
	lw t2, 804(s0)
	addiw t0, s0, -2047
	sd t2, -313(t0)
	lw t2, 808(s0)
	addiw t0, s0, -2047
	sd t2, -305(t0)
	lw t2, 812(s0)
	lw t2, 816(s0)
	addiw t0, s0, -2047
	sd t2, -297(t0)
	lw t2, 820(s0)
	addiw t0, s0, -2047
	sd t2, -289(t0)
	lw t2, 824(s0)
	addiw t0, s0, -2047
	sd t2, -281(t0)
	lw t2, 828(s0)
	addiw t0, s0, -2047
	sd t2, -273(t0)
	lw t2, 832(s0)
	addiw t0, s0, -2047
	sd t2, -193(t0)
	lw t2, 836(s0)
	addiw t0, s0, -2047
	sd t2, -257(t0)
	lw t2, 840(s0)
	addiw t0, s0, -2047
	sd t2, -249(t0)
	lw t2, 844(s0)
	addiw t0, s0, -2047
	sd t2, -241(t0)
	lw t3, 848(s0)
	lw t2, 852(s0)
	addiw t0, s0, -2047
	sd t2, -233(t0)
	lw t2, 856(s0)
	lw s3, 860(s0)
	lw t2, 864(s0)
	addiw t0, s0, -2047
	sd t2, -225(t0)
	lw t2, 868(s0)
	lw t2, 872(s0)
	lw t2, 876(s0)
	addiw t0, s0, -2047
	sd t2, -217(t0)
	lw s7, 880(s0)
	lw t2, 884(s0)
	lw t2, 888(s0)
	lw t2, 892(s0)
	lw s8, 896(s0)
	lw t2, 900(s0)
	lw t2, 904(s0)
	lw s5, 908(s0)
	lw t2, 912(s0)
	lw t2, 916(s0)
	lw t2, 920(s0)
	lw t2, 924(s0)
	lw t2, 928(s0)
	lw t2, 932(s0)
	lw t2, 936(s0)
	lw t4, 940(s0)
	lw t2, 944(s0)
	lw t2, 948(s0)
	addiw t0, s0, -2047
	sd t2, -209(t0)
	lw t2, 952(s0)
	lw s6, 956(s0)
	lw t2, 960(s0)
	lw t2, 964(s0)
	addiw t0, s0, -2047
	sd t2, -201(t0)
	lw t2, 968(s0)
	lw t2, 972(s0)
	lw t2, 976(s0)
	sd t2, -2024(s0)
	lw t2, 980(s0)
	sd t2, -1944(s0)
	lw t2, 984(s0)
	sd t2, -1936(s0)
	lw t2, 988(s0)
	sd t2, -1928(s0)
	lw t2, 992(s0)
	lw t2, 996(s0)
	lw t2, 1000(s0)
	sd t2, -1920(s0)
	lw t2, 1004(s0)
	lw t2, 1008(s0)
	sd t2, -1912(s0)
	lw t2, 1012(s0)
	sd t2, -1904(s0)
	lw t2, 1016(s0)
	lw t2, 1020(s0)
	sd t2, -1896(s0)
	lw t2, 1024(s0)
	sd t2, -1888(s0)
	lw t2, 1028(s0)
	lw t2, 1032(s0)
	sd t2, -1800(s0)
	lw t2, 1036(s0)
	lw t2, 1040(s0)
	sd t2, -1872(s0)
	lw t2, 1044(s0)
	lw t2, 1048(s0)
	sd t2, -1864(s0)
	lw t2, 1052(s0)
	sd t2, -1856(s0)
	lw t2, 1056(s0)
	sd t2, -1848(s0)
	lw t2, 1060(s0)
	sd t2, -1840(s0)
	lw t2, 1064(s0)
	sd t2, -1832(s0)
	lw t2, 1068(s0)
	lw t2, 1072(s0)
	lw t2, 1076(s0)
	lw t2, 1080(s0)
	sd t2, -1824(s0)
	lw t2, 1084(s0)
	sd t2, -1816(s0)
	lw t2, 1088(s0)
	sd t2, -1808(s0)
	lw t2, 1092(s0)
	lw t2, 1096(s0)
	sd t2, -1880(s0)
	lw t2, 1100(s0)
	addiw t0, s0, -2047
	sd t2, -41(t0)
	lw t2, 1104(s0)
	lw t2, 1108(s0)
	addiw t0, s0, -2047
	sd t2, -33(t0)
	lw t2, 1112(s0)
	lw t2, 1116(s0)
	lw t2, 1120(s0)
	addiw t0, s0, -2047
	sd t2, -25(t0)
	lw t2, 1124(s0)
	lw t2, 1128(s0)
	addiw t0, s0, -2047
	sd t2, -17(t0)
	lw t2, 1132(s0)
	lw t2, 1136(s0)
	lw t2, 1140(s0)
	addiw t0, s0, -2047
	sd t2, -9(t0)
	lw t2, 1144(s0)
	sd t2, -2048(s0)
	lw t2, 1148(s0)
	sd t2, -2040(s0)
	lw t2, 1152(s0)
	lw t2, 1156(s0)
	lw t2, 1160(s0)
	sd t2, -2032(s0)
	lw t2, 1164(s0)
	lw t2, 1168(s0)
	lw t2, 1172(s0)
	lw t2, 1176(s0)
	lw t2, 1180(s0)
	lw t2, 1184(s0)
	sd t2, -1952(s0)
	lw t2, 1188(s0)
	lw t2, 1192(s0)
	lw t2, 1196(s0)
	lw t2, 1200(s0)
	sd t2, -2016(s0)
	lw t2, 1204(s0)
	sd t2, -2008(s0)
	lw t2, 1208(s0)
	lw t2, 1212(s0)
	lw t2, 1216(s0)
	lw t2, 1220(s0)
	lw t2, 1224(s0)
	lw t2, 1228(s0)
	lw t2, 1232(s0)
	lw t2, 1236(s0)
	sd t2, -2000(s0)
	lw t2, 1240(s0)
	sd t2, -1992(s0)
	lw t2, 1244(s0)
	lw t2, 1248(s0)
	lw t2, 1252(s0)
	lw t2, 1256(s0)
	lw t2, 1260(s0)
	lw t2, 1264(s0)
	lw t2, 1268(s0)
	lw t2, 1272(s0)
	lw t2, 1276(s0)
	lw t2, 1280(s0)
	sd t2, -1984(s0)
	lw t2, 1284(s0)
	sd t2, -1976(s0)
	lw t2, 1288(s0)
	lw t2, 1292(s0)
	lw t2, 1296(s0)
	sd t2, -1968(s0)
	lw t2, 1300(s0)
	sd t2, -1960(s0)
	lw t2, 1304(s0)
	lw t2, 1308(s0)
	lw t2, 1312(s0)
	sd t2, -1136(s0)
	lw t2, 1316(s0)
	sd t2, -464(s0)
	lw t2, 1320(s0)
	lw t2, 1324(s0)
	lw t2, 1328(s0)
	sd t2, -456(s0)
	lw t2, 1332(s0)
	sd t2, -448(s0)
	lw t2, 1336(s0)
	sd t2, -440(s0)
	lw t2, 1340(s0)
	lw t2, 1344(s0)
	lw t2, 1348(s0)
	lw t2, 1352(s0)
	lw t2, 1356(s0)
	lw t2, 1360(s0)
	lw t2, 1364(s0)
	sd t2, -432(s0)
	lw t2, 1368(s0)
	sd t2, -424(s0)
	lw t2, 1372(s0)
	lw t2, 1376(s0)
	lw t2, 1380(s0)
	lw t2, 1384(s0)
	lw t2, 1388(s0)
	sd t2, -416(s0)
	lw t2, 1392(s0)
	lw t2, 1396(s0)
	sd t2, -408(s0)
	lw t2, 1400(s0)
	lw t2, 1404(s0)
	lw t2, 1408(s0)
	lw t2, 1412(s0)
	lw t2, 1416(s0)
	lw t2, 1420(s0)
	lw t2, 1424(s0)
	sd t2, -320(s0)
	lw t2, 1428(s0)
	sd t2, -392(s0)
	lw t2, 1432(s0)
	sd t2, -384(s0)
	lw t2, 1436(s0)
	lw t2, 1440(s0)
	lw t2, 1444(s0)
	lw t2, 1448(s0)
	lw t2, 1452(s0)
	sd t2, -376(s0)
	lw t2, 1456(s0)
	sd t2, -368(s0)
	lw t2, 1460(s0)
	lw t2, 1464(s0)
	lw t2, 1468(s0)
	lw t2, 1472(s0)
	lw t6, 1476(s0)
	lw t5, 1480(s0)
	lw t2, 1484(s0)
	sd t2, -360(s0)
	lw t2, 1488(s0)
	lw t2, 1492(s0)
	lw t2, 1496(s0)
	lw t2, 1500(s0)
	lw t2, 1504(s0)
	lw t2, 1508(s0)
	sd t2, -352(s0)
	lw t2, 1512(s0)
	lw t2, 1516(s0)
	sd t2, -784(s0)
	lw t2, 1520(s0)
	lw s2, 1524(s0)
	lw s9, 1528(s0)
	lw t2, 1532(s0)
	sd t2, -344(s0)
	lw s1, 1536(s0)
	lw t2, 1540(s0)
	lw t2, 1544(s0)
	sd t2, -336(s0)
	lw t2, 1548(s0)
	lw t2, 1552(s0)
	sd t2, -776(s0)
	lw t2, 1556(s0)
	lw t2, 1560(s0)
	lw t2, 1564(s0)
	lw t2, 1568(s0)
	lw s10, 1572(s0)
	lw s4, 1576(s0)
	lw t2, 1580(s0)
	sd t2, -328(s0)
	lw t2, 1584(s0)
	lw t2, 1588(s0)
	sd t2, -400(s0)
	lw t2, 1592(s0)
	lw t2, 1596(s0)
	sd t2, -608(s0)
	lw t2, 1600(s0)
	lw t2, 1604(s0)
	lw t2, 1608(s0)
	lw t2, 1612(s0)
	sd t2, -600(s0)
	lw t2, 1616(s0)
	lw t2, 1620(s0)
	lw t2, 1624(s0)
	lw t2, 1628(s0)
	sd t2, -592(s0)
	lw t2, 1632(s0)
	sd t2, -584(s0)
	lw t2, 1636(s0)
	sd t2, -576(s0)
	lw t2, 1640(s0)
	lw t2, 1644(s0)
	lw t2, 1648(s0)
	lw t2, 1652(s0)
	lw t2, 1656(s0)
	lw t2, 1660(s0)
	sd t2, -568(s0)
	lw t2, 1664(s0)
	lw t2, 1668(s0)
	sd t2, -560(s0)
	lw t2, 1672(s0)
	sd t2, -552(s0)
	lw t2, 1676(s0)
	lw t2, 1680(s0)
	lw t2, 1684(s0)
	lw t2, 1688(s0)
	lw t2, 1692(s0)
	sd t2, -472(s0)
	lw t2, 1696(s0)
	sd t2, -536(s0)
	lw t2, 1700(s0)
	sd t2, -528(s0)
	lw t2, 1704(s0)
	sd t2, -520(s0)
	lw t2, 1708(s0)
	lw t2, 1712(s0)
	sd t2, -512(s0)
	lw t2, 1716(s0)
	lw t2, 1720(s0)
	lw t2, 1724(s0)
	lw t2, 1728(s0)
	sd t2, -504(s0)
	lw t2, 1732(s0)
	lw t2, 1736(s0)
	sd t2, -496(s0)
	lw t2, 1740(s0)
	lw t2, 1744(s0)
	lw t2, 1748(s0)
	sd t2, -488(s0)
	lw t2, 1752(s0)
	sd t2, -480(s0)
	lw t2, 1756(s0)
	lw t2, 1760(s0)
	lw t2, 1764(s0)
	lw t2, 1768(s0)
	sd t2, -248(s0)
	lw t2, 1772(s0)
	sd t2, -168(s0)
	lw t2, 1776(s0)
	lw t2, 1780(s0)
	lw t2, 1784(s0)
	lw t2, 1788(s0)
	sd t2, -160(s0)
	lw t2, 1792(s0)
	lw t2, 1796(s0)
	lw t2, 1800(s0)
	sd t2, -152(s0)
	lw t2, 1804(s0)
	sd t2, -144(s0)
	lw t2, 1808(s0)
	lw t2, 1812(s0)
	lw t2, 1816(s0)
	sd t2, -136(s0)
	lw t2, 1820(s0)
	sd t2, -128(s0)
	lw t2, 1824(s0)
	lw t2, 1828(s0)
	sd t2, -120(s0)
	lw t2, 1832(s0)
	lw t2, 1836(s0)
	sd t2, -112(s0)
	lw t2, 1840(s0)
	sd t2, -24(s0)
	lw t2, 1844(s0)
	sd t2, -96(s0)
	lw t2, 1848(s0)
	sd t2, -88(s0)
	lw t2, 1852(s0)
	sd t2, -80(s0)
	lw t2, 1856(s0)
	lw t2, 1860(s0)
	lw t2, 1864(s0)
	sd t2, -72(s0)
	lw t2, 1868(s0)
	sd t2, -64(s0)
	lw t2, 1872(s0)
	lw t2, 1876(s0)
	sd t2, -56(s0)
	lw t2, 1880(s0)
	lw t2, 1884(s0)
	sd t2, -48(s0)
	lw t2, 1888(s0)
	lw t2, 1892(s0)
	lw t2, 1896(s0)
	sd t2, -40(s0)
	lw t2, 1900(s0)
	lw t2, 1904(s0)
	sd t2, -32(s0)
	lw t2, 1908(s0)
	lw t2, 1912(s0)
	sd t2, -104(s0)
	lw t2, 1916(s0)
	sd t2, -312(s0)
	lw t2, 1920(s0)
	lw t2, 1924(s0)
	sd t2, -304(s0)
	lw t2, 1928(s0)
	lw t2, 1932(s0)
	lw t2, 1936(s0)
	lw t2, 1940(s0)
	lw t2, 1944(s0)
	sd t2, -296(s0)
	lw t2, 1948(s0)
	lw t2, 1952(s0)
	sd t2, -288(s0)
	lw t2, 1956(s0)
	sd t2, -280(s0)
	lw t2, 1960(s0)
	sd t2, -272(s0)
	lw t2, 1964(s0)
	lw t2, 1968(s0)
	lw t2, 1972(s0)
	sd t2, -264(s0)
	lw t2, 1976(s0)
	lw t2, 1980(s0)
	lw t2, 1984(s0)
	lw t2, 1988(s0)
	sd t2, -256(s0)
	lw t2, 1992(s0)
	sd t2, -176(s0)
	lw t2, 1996(s0)
	lw t2, 2000(s0)
	lw t2, 2004(s0)
	lw t2, 2008(s0)
	sd t2, -240(s0)
	lw t2, 2012(s0)
	lw t2, 2016(s0)
	sd t2, -232(s0)
	lw t2, 2020(s0)
	sd t2, -224(s0)
	lw t2, 2024(s0)
	lw t2, 2028(s0)
	sd t2, -216(s0)
	lw t2, 2032(s0)
	lw t2, 2036(s0)
	lw t2, 2040(s0)
	sd t2, -208(s0)
	lw t2, 2044(s0)
	addiw t0, s0, 2047
	lw t2, 1(t0)
	sd t2, -200(s0)
	addiw t0, s0, 2047
	lw t2, 5(t0)
	addiw t0, s0, 2047
	lw t2, 9(t0)
	sd t2, -192(s0)
	addiw t0, s0, 2047
	lw t2, 13(t0)
	addiw t0, s0, 2047
	lw t2, 17(t0)
	sd t2, -184(s0)
	addiw t0, s0, 2047
	lw t2, 21(t0)
	addiw t0, s0, 2047
	lw t2, 25(t0)
	sd t2, -544(s0)
	addiw t0, s0, 2047
	lw t2, 29(t0)
	addiw t0, s0, 2047
	lw t2, 33(t0)
	sd t2, -1056(s0)
	addiw t0, s0, 2047
	lw t2, 37(t0)
	sd t2, -1048(s0)
	addiw t0, s0, 2047
	lw t2, 41(t0)
	addiw t0, s0, 2047
	lw t2, 45(t0)
	sd t2, -1040(s0)
	addiw t0, s0, 2047
	lw t2, 49(t0)
	addiw t0, s0, 2047
	lw t2, 53(t0)
	addiw t0, s0, 2047
	lw t2, 57(t0)
	sd t2, -1032(s0)
	addiw t0, s0, 2047
	lw t2, 61(t0)
	sd t2, -1024(s0)
	addiw t0, s0, 2047
	lw t2, 65(t0)
	addiw t0, s0, 2047
	lw t2, 69(t0)
	addiw t0, s0, 2047
	lw t2, 73(t0)
	addiw t0, s0, 2047
	lw t2, 77(t0)
	sd t2, -1016(s0)
	addiw t0, s0, 2047
	lw t2, 81(t0)
	sd t2, -1008(s0)
	addiw t0, s0, 2047
	lw t2, 85(t0)
	sd t2, -1000(s0)
	addiw t0, s0, 2047
	lw t2, 89(t0)
	addiw t0, s0, 2047
	lw t2, 93(t0)
	addiw t0, s0, 2047
	lw t2, 97(t0)
	addiw t0, s0, 2047
	lw t2, 101(t0)
	sd t2, -912(s0)
	addiw t0, s0, 2047
	lw t2, 105(t0)
	sd t2, -984(s0)
	addiw t0, s0, 2047
	lw t2, 109(t0)
	sd t2, -976(s0)
	addiw t0, s0, 2047
	lw t2, 113(t0)
	addiw t0, s0, 2047
	lw t2, 117(t0)
	sd t2, -968(s0)
	addiw t0, s0, 2047
	lw t2, 121(t0)
	sd t2, -960(s0)
	addiw t0, s0, 2047
	lw t2, 125(t0)
	sd t2, -952(s0)
	addiw t0, s0, 2047
	lw t2, 129(t0)
	addiw t0, s0, 2047
	lw t2, 133(t0)
	sd t2, -944(s0)
	addiw t0, s0, 2047
	lw t2, 137(t0)
	addiw t0, s0, 2047
	lw t2, 141(t0)
	sd t2, -936(s0)
	addiw t0, s0, 2047
	lw t2, 145(t0)
	sd t2, -928(s0)
	addiw t0, s0, 2047
	lw t2, 149(t0)
	addiw t0, s0, 2047
	lw t2, 153(t0)
	addiw t0, s0, 2047
	lw t2, 157(t0)
	addiw t0, s0, 2047
	lw t2, 161(t0)
	addiw t0, s0, 2047
	lw t2, 165(t0)
	addiw t0, s0, 2047
	lw t2, 169(t0)
	addiw t0, s0, 2047
	lw t2, 173(t0)
	sd t2, -920(s0)
	addiw t0, s0, 2047
	lw t2, 177(t0)
	sd t2, -992(s0)
	addiw t0, s0, 2047
	lw t2, 181(t0)
	addiw t0, s0, 2047
	lw t2, 185(t0)
	sd t2, -1200(s0)
	addiw t0, s0, 2047
	lw t2, 189(t0)
	sd t2, -1192(s0)
	addiw t0, s0, 2047
	lw t2, 193(t0)
	sd t2, -1184(s0)
	addiw t0, s0, 2047
	lw t2, 197(t0)
	addiw t0, s0, 2047
	lw t2, 201(t0)
	addiw t0, s0, 2047
	lw t2, 205(t0)
	sd t2, -1176(s0)
	addiw t0, s0, 2047
	lw t2, 209(t0)
	addiw t0, s0, 2047
	lw t2, 213(t0)
	addiw t0, s0, 2047
	lw t2, 217(t0)
	addiw t0, s0, 2047
	lw t2, 221(t0)
	addiw t0, s0, 2047
	lw t2, 225(t0)
	sd t2, -1168(s0)
	addiw t0, s0, 2047
	lw t2, 229(t0)
	addiw t0, s0, 2047
	lw t2, 233(t0)
	sd t2, -1160(s0)
	addiw t0, s0, 2047
	lw t2, 237(t0)
	sd t2, -1152(s0)
	addiw t0, s0, 2047
	lw t2, 241(t0)
	addiw t0, s0, 2047
	lw t2, 245(t0)
	sd t2, -1144(s0)
	addiw t0, s0, 2047
	lw t2, 249(t0)
	addiw t0, s0, 2047
	lw t2, 253(t0)
	sd t2, -1064(s0)
	addiw t0, s0, 2047
	lw t2, 257(t0)
	sd t2, -1128(s0)
	addiw t0, s0, 2047
	lw t2, 261(t0)
	addiw t0, s0, 2047
	lw t2, 265(t0)
	sd t2, -1120(s0)
	addiw t0, s0, 2047
	lw t2, 269(t0)
	sd t2, -1112(s0)
	addiw t0, s0, 2047
	lw t2, 273(t0)
	addiw t0, s0, 2047
	lw t2, 277(t0)
	sd t2, -1104(s0)
	addiw t0, s0, 2047
	lw t2, 281(t0)
	sd t2, -1096(s0)
	addiw t0, s0, 2047
	lw t2, 285(t0)
	sd t2, -1088(s0)
	addiw t0, s0, 2047
	lw t2, 289(t0)
	addiw t0, s0, 2047
	lw t2, 293(t0)
	addiw t0, s0, 2047
	lw t2, 297(t0)
	sd t2, -1080(s0)
	addiw t0, s0, 2047
	lw t2, 301(t0)
	sd t2, -1072(s0)
	addiw t0, s0, 2047
	lw t2, 305(t0)
	addiw t0, s0, 2047
	lw t2, 309(t0)
	addiw t0, s0, 2047
	lw t2, 313(t0)
	sd t2, -840(s0)
	addiw t0, s0, 2047
	lw t2, 317(t0)
	addiw t0, s0, 2047
	lw t2, 321(t0)
	addiw t0, s0, 2047
	lw t2, 325(t0)
	addiw t0, s0, 2047
	lw t2, 329(t0)
	sd t2, -760(s0)
	addiw t0, s0, 2047
	lw t2, 333(t0)
	sd t2, -752(s0)
	addiw t0, s0, 2047
	lw t2, 337(t0)
	sd t2, -744(s0)
	addiw t0, s0, 2047
	lw t2, 341(t0)
	addiw t0, s0, 2047
	lw t2, 345(t0)
	addiw t0, s0, 2047
	lw t2, 349(t0)
	sd t2, -736(s0)
	addiw t0, s0, 2047
	lw t2, 353(t0)
	sd t2, -728(s0)
	addiw t0, s0, 2047
	lw t2, 357(t0)
	addiw t0, s0, 2047
	lw t2, 361(t0)
	addiw t0, s0, 2047
	lw t2, 365(t0)
	addiw t0, s0, 2047
	lw t2, 369(t0)
	addiw t0, s0, 2047
	lw t2, 373(t0)
	sd t2, -720(s0)
	addiw t0, s0, 2047
	lw t2, 377(t0)
	addiw t0, s0, 2047
	lw t2, 381(t0)
	addiw t0, s0, 2047
	lw t2, 385(t0)
	addiw t0, s0, 2047
	lw t2, 389(t0)
	sd t2, -712(s0)
	addiw t0, s0, 2047
	lw t2, 393(t0)
	addiw t0, s0, 2047
	lw t2, 397(t0)
	addiw t0, s0, 2047
	lw t2, 401(t0)
	addiw t0, s0, 2047
	lw t2, 405(t0)
	addiw t0, s0, 2047
	lw t2, 409(t0)
	sd t2, -704(s0)
	addiw t0, s0, 2047
	lw t2, 413(t0)
	sd t2, -616(s0)
	addiw t0, s0, 2047
	lw t2, 417(t0)
	addiw t0, s0, 2047
	lw t2, 421(t0)
	sd t2, -688(s0)
	addiw t0, s0, 2047
	lw t2, 425(t0)
	addiw t0, s0, 2047
	lw t2, 429(t0)
	addiw t0, s0, 2047
	lw t2, 433(t0)
	addiw t0, s0, 2047
	lw t2, 437(t0)
	addiw t0, s0, 2047
	lw t2, 441(t0)
	sd t2, -680(s0)
	addiw t0, s0, 2047
	lw t2, 445(t0)
	addiw t0, s0, 2047
	lw t2, 449(t0)
	addiw t0, s0, 2047
	lw t2, 453(t0)
	sd t2, -672(s0)
	addiw t0, s0, 2047
	lw t2, 457(t0)
	sd t2, -664(s0)
	addiw t0, s0, 2047
	lw t2, 461(t0)
	addiw t0, s0, 2047
	lw t2, 465(t0)
	sd t2, -656(s0)
	addiw t0, s0, 2047
	lw t2, 469(t0)
	sd t2, -648(s0)
	addiw t0, s0, 2047
	lw t2, 473(t0)
	sd t2, -640(s0)
	addiw t0, s0, 2047
	lw t2, 477(t0)
	addiw t0, s0, 2047
	lw t2, 481(t0)
	addiw t0, s0, 2047
	lw t2, 485(t0)
	addiw t0, s0, 2047
	lw t2, 489(t0)
	addiw t0, s0, 2047
	lw t2, 493(t0)
	sd t2, -632(s0)
	addiw t0, s0, 2047
	lw t2, 497(t0)
	sd t2, -624(s0)
	addiw t0, s0, 2047
	lw t2, 501(t0)
	sd t2, -696(s0)
	addiw t0, s0, 2047
	lw t2, 505(t0)
	addiw t0, s0, 2047
	lw t2, 509(t0)
	sd t2, -904(s0)
	addiw t0, s0, 2047
	lw t2, 513(t0)
	addiw t0, s0, 2047
	lw t2, 517(t0)
	sd t2, -896(s0)
	addiw t0, s0, 2047
	lw t2, 521(t0)
	sd t2, -888(s0)
	addiw t0, s0, 2047
	lw t2, 525(t0)
	sd t2, -880(s0)
	addiw t0, s0, 2047
	lw t2, 529(t0)
	addiw t0, s0, 2047
	lw t2, 533(t0)
	addiw t0, s0, 2047
	lw t2, 537(t0)
	sd t2, -872(s0)
	addiw t0, s0, 2047
	lw t2, 541(t0)
	sd t2, -864(s0)
	addiw t0, s0, 2047
	lw t2, 545(t0)
	sd t2, -856(s0)
	addiw t0, s0, 2047
	lw t2, 549(t0)
	addiw t0, s0, 2047
	lw t2, 553(t0)
	sd t2, -848(s0)
	addiw t0, s0, 2047
	lw t2, 557(t0)
	sd t2, -768(s0)
	addiw t0, s0, 2047
	lw t2, 561(t0)
	addiw t0, s0, 2047
	lw t2, 565(t0)
	sd t2, -832(s0)
	addiw t0, s0, 2047
	lw t2, 569(t0)
	addiw t0, s0, 2047
	lw t2, 573(t0)
	addiw t0, s0, 2047
	lw t2, 577(t0)
	addiw t0, s0, 2047
	lw t2, 581(t0)
	addiw t0, s0, 2047
	lw t2, 585(t0)
	addiw t0, s0, 2047
	lw t2, 589(t0)
	addiw t0, s0, 2047
	lw t2, 593(t0)
	sd t2, -824(s0)
	addiw t0, s0, 2047
	lw t2, 597(t0)
	sd t2, -816(s0)
	addiw t0, s0, 2047
	lw t2, 601(t0)
	sd t2, -808(s0)
	addiw t0, s0, 2047
	lw t2, 605(t0)
	sd t2, -800(s0)
	addiw t0, s0, 2047
	lw t2, 609(t0)
	addiw t0, s0, 2047
	lw t2, 613(t0)
	sd t2, -792(s0)
	addiw t0, s0, 2047
	lw t2, 617(t0)
	addiw t0, s0, 2047
	lw t2, 621(t0)
	mv a0, a0
	mv a1, a1
	mv a2, a2
	mv a3, a3
	mv a4, a4
	mv a5, a5
	mv a6, a6
	mv a7, a7
	j .LBB1
.LBB1:
	ld t2, -704(s0)
	ld t2, -848(s0)
	mulw t2, t2, t2
	ld t2, -960(s0)
	mulw t2, t2, t2
	ld t2, -832(s0)
	mulw t2, t2, t2
	ld t2, -1352(s0)
	mulw t2, t2, t2
	ld t2, -1056(s0)
	addw s0, t2, t2
	ld t2, -1784(s0)
	ld t2, -80(s0)
	mulw t2, t2, t2
	ld t2, -528(s0)
	mulw t2, t2, t2
	ld t2, -1864(s0)
	mulw t2, t2, t2
	ld t2, -552(s0)
	mulw t2, t2, t2
	ld t2, -1944(s0)
	mulw t2, t2, t2
	ld t2, -736(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1160(s0)
	ld t2, -1064(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1904(s0)
	addw s0, t2, t2
	ld t2, -193(t0)
	ld t2, -936(s0)
	mulw t2, t2, t2
	ld t2, -320(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1808(s0)
	ld t2, -344(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -1264(s0)
	ld t2, -1416(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -145(t0)
	addw s0, t2, t2
	ld t2, -1536(s0)
	ld t2, -1928(s0)
	mulw t2, t2, t2
	ld t2, -1912(s0)
	mulw t2, t2, t2
	ld t2, -1976(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -153(t0)
	addw t2, t2, t2
	ld t2, -568(s0)
	addw t2, t2, t2
	ld t2, -1760(s0)
	addw s0, t2, t2
	ld t2, -1576(s0)
	ld t2, -2040(s0)
	mulw t2, t2, t2
	ld t2, -297(t0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -592(s0)
	ld t2, -856(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -2024(s0)
	ld t2, -1144(s0)
	mulw t2, t2, t2
	ld t2, -241(t0)
	mulw t2, t2, t2
	ld t2, -1408(s0)
	mulw t2, t2, t2
	ld t2, -992(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1272(s0)
	addw t2, t2, t2
	ld t2, -272(s0)
	addw t2, t2, t2
	ld t2, -1888(s0)
	addw t2, t2, t2
	ld t2, -81(t0)
	ld t2, -32(s0)
	mulw s0, t2, t2
	ld t2, -1680(s0)
	mulw s0, t2, s0
	addw t2, s0, t2
	ld t2, -169(t0)
	ld t2, -976(s0)
	mulw s0, t2, t2
	addw s0, s0, t2
	ld t2, -41(t0)
	mulw t2, a1, t2
	ld t2, -25(t0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -328(s0)
	mulw t2, a4, t2
	addw t2, t2, s0
	ld t2, -1704(s0)
	mulw s0, t2, t6
	addw t2, s0, t2
	ld t2, -760(s0)
	addw t2, t2, t2
	ld t2, -848(s0)
	addw t2, t2, t2
	ld t2, -2000(s0)
	addw s0, t2, t2
	ld t2, -1648(s0)
	ld t2, -88(s0)
	mulw t2, t2, t2
	ld t2, -1832(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1592(s0)
	ld t2, -121(t0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1736(s0)
	ld t2, -1392(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1512(s0)
	ld t2, -1448(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -1040(s0)
	addw t2, t2, t2
	ld t2, -1240(s0)
	addw t2, t2, t2
	ld t2, -408(s0)
	addw s0, t2, t2
	ld t2, -1256(s0)
	ld t2, -224(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -161(t0)
	addw s0, t2, t2
	ld t2, -1048(s0)
	ld t2, -1024(s0)
	mulw t2, t2, t2
	ld t2, -33(t0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -672(s0)
	addw s0, t2, t2
	ld t2, -1344(s0)
	mulw t2, a7, t2
	ld t2, -616(s0)
	mulw t2, t2, t2
	ld t2, -241(t0)
	mulw t2, t2, t2
	ld t2, -1848(s0)
	mulw t2, t2, t2
	ld t2, -472(s0)
	mulw t2, t2, t2
	ld t2, -904(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -25(t0)
	addw s0, t2, t2
	ld t2, -576(s0)
	ld t2, -480(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -432(s0)
	addw t2, t2, t2
	addw t2, t6, t2
	ld t2, -161(t0)
	addw t2, t2, t2
	ld t2, -824(s0)
	addw t2, t2, t2
	ld t2, -9(t0)
	mulw s0, s11, t2
	addw t2, s0, t2
	ld t2, -496(s0)
	addw s0, t2, t2
	ld t2, -1320(s0)
	ld t2, -360(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1744(s0)
	ld t2, -1216(s0)
	mulw t2, t2, t2
	mulw t2, a3, t2
	addw t2, t2, s0
	ld t2, -1904(s0)
	addw t2, t2, t2
	ld t2, -288(s0)
	addw s0, t2, t2
	ld t2, -1568(s0)
	mulw t2, t2, t5
	addw t2, t2, s0
	ld t2, -1992(s0)
	addw t2, t2, t2
	ld t2, -1096(s0)
	ld t2, -736(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -248(s0)
	ld t2, -208(s0)
	mulw s0, t2, t2
	ld t2, -1968(s0)
	mulw s0, t2, s0
	addw t2, s0, t2
	ld t2, -1688(s0)
	addw t2, t2, t2
	ld t2, -1312(s0)
	ld t2, -1128(s0)
	mulw s0, t2, t2
	ld t2, -1088(s0)
	mulw s0, s0, t2
	addw t2, s0, t2
	ld t2, -1208(s0)
	addw t2, t2, t2
	ld t2, -600(s0)
	addw t2, t2, t2
	ld t2, -217(t0)
	addw t2, t2, t2
	addw t2, s8, t2
	ld t2, -217(t0)
	addw s0, t2, t2
	ld t2, -57(t0)
	ld t2, -888(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -41(t0)
	mulw t2, t2, s1
	ld t2, -824(s0)
	mulw t2, t2, t2
	ld t2, -65(t0)
	mulw t2, t2, t2
	ld t2, -304(s0)
	mulw t2, t2, t2
	ld t2, -1920(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -185(t0)
	addw t2, t2, t2
	ld t2, -1720(s0)
	ld t2, -656(s0)
	mulw s0, t2, t2
	ld t2, -1176(s0)
	mulw s0, t2, s0
	ld t2, -1672(s0)
	mulw s0, t2, s0
	ld t2, -1368(s0)
	mulw s0, t2, s0
	addw s0, s0, t2
	ld t2, -1352(s0)
	ld t2, -1480(s0)
	mulw t2, t2, t2
	ld t2, -688(s0)
	mulw t2, t2, t2
	ld t2, -1128(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -808(s0)
	addw s0, t2, t2
	ld t2, -1528(s0)
	ld t2, -264(s0)
	mulw t2, t2, t2
	mulw t2, s8, t2
	ld t2, -1320(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1640(s0)
	addw s0, t2, t2
	ld t2, -1496(s0)
	ld t2, -936(s0)
	mulw t2, t2, t2
	ld t2, -1432(s0)
	mulw t2, t2, t2
	mulw t2, s5, t2
	ld t2, -104(s0)
	mulw t2, t2, t2
	ld t2, -1560(s0)
	mulw t2, t2, t2
	ld t2, -1840(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -896(s0)
	addw t2, t2, t2
	ld t2, -1880(s0)
	addw s0, t2, t2
	ld t2, -216(s0)
	ld t2, -544(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -289(t0)
	ld t2, -1072(s0)
	mulw t2, t2, t2
	ld t2, -1440(s0)
	mulw t2, t2, t2
	ld t2, -1040(s0)
	mulw t2, t2, t2
	ld t2, -224(s0)
	mulw t2, t2, t2
	ld t2, -1424(s0)
	mulw t2, t2, t2
	ld t2, -89(t0)
	mulw t2, t2, t2
	ld t2, -1296(s0)
	mulw t2, t2, t2
	ld t2, -800(s0)
	mulw t2, t2, t2
	ld t2, -1640(s0)
	mulw t2, t2, t2
	ld t2, -1104(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1488(s0)
	ld t2, -1192(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1952(s0)
	addw t2, t2, t2
	ld t2, -321(t0)
	mulw s0, t2, s3
	ld t2, -1000(s0)
	mulw s0, s0, t2
	addw t2, s0, t2
	ld t2, -2048(s0)
	addw t2, t2, t2
	ld t2, -824(s0)
	addw t2, t2, t2
	ld t2, -1232(s0)
	addw t2, t2, t2
	ld t2, -864(s0)
	mulw s0, s9, t2
	addw t2, s0, t2
	ld t2, -880(s0)
	addw t2, t2, t2
	ld t2, -1584(s0)
	addw t2, t2, t2
	addw t2, a3, t2
	ld t2, -201(t0)
	addw t2, t2, t2
	ld t2, -1016(s0)
	addw t2, t2, t2
	ld t2, -176(s0)
	addw t2, t2, t2
	ld t2, -1216(s0)
	addw t2, t2, t2
	ld t2, -1696(s0)
	addw t2, t2, t2
	ld t2, -129(t0)
	addw s0, t2, t2
	ld t2, -1224(s0)
	ld t2, -49(t0)
	mulw t2, t2, t2
	ld t2, -113(t0)
	mulw t2, t2, t2
	ld t2, -1712(s0)
	mulw t2, t2, t2
	ld t2, -2032(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -400(s0)
	ld t2, -1144(s0)
	mulw t2, t2, t2
	ld t2, -448(s0)
	mulw t2, t2, t2
	ld t2, -1912(s0)
	mulw t2, t2, t2
	ld t2, -296(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -136(s0)
	mulw t2, s6, t2
	addw t2, t2, s0
	ld t2, -1224(s0)
	addw t2, t2, t2
	ld t2, -1392(s0)
	mulw s0, t2, s5
	addw t2, s0, t2
	ld t2, -1544(s0)
	ld t2, -1800(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -48(s0)
	addw t2, t2, t2
	ld t2, -608(s0)
	addw t2, t2, t2
	ld t2, -192(s0)
	addw t2, t2, t2
	ld t2, -696(s0)
	addw t2, t2, t2
	ld t2, -280(s0)
	ld t2, -968(s0)
	mulw s0, t2, t2
	ld t2, -744(s0)
	mulw s0, s0, t2
	addw s0, s0, t2
	ld t2, -1656(s0)
	ld t2, -168(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -512(s0)
	addw t2, t2, t2
	ld t2, -1624(s0)
	ld t2, -1184(s0)
	mulw s0, t2, t2
	mulw s0, s2, s0
	addw t2, s0, t2
	ld t2, -864(s0)
	addw t2, t2, t2
	ld t2, -560(s0)
	addw s0, t2, t2
	ld t2, -1856(s0)
	ld t2, -312(s0)
	mulw t2, t2, t2
	mulw t2, t6, t2
	ld t2, -536(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1288(s0)
	ld t2, -1960(s0)
	mulw t2, t2, t2
	ld t2, -1504(s0)
	mulw t2, t2, t2
	ld t2, -273(t0)
	mulw t2, t2, t2
	ld t2, -296(s0)
	mulw t2, t2, t2
	ld t2, -176(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -944(s0)
	addw t2, t2, t2
	ld t2, -112(s0)
	addw t2, t2, t2
	ld t2, -1520(s0)
	ld t2, -648(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -608(s0)
	addw s0, t2, t2
	ld t2, -2016(s0)
	ld t2, -712(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1032(s0)
	ld t2, -832(s0)
	mulw t2, t2, t2
	ld t2, -128(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1400(s0)
	ld t2, -112(s0)
	mulw t2, t2, t2
	ld t2, -1400(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -2000(s0)
	ld t2, -56(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -616(s0)
	ld t2, -632(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -560(s0)
	addw s0, t2, t2
	ld t2, -1376(s0)
	ld t2, -1872(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -440(s0)
	addw t2, t2, t2
	ld t2, -1384(s0)
	addw t2, t2, t2
	ld t2, -1176(s0)
	addw t2, t2, t2
	ld t2, -376(s0)
	addw t2, t2, t2
	ld t2, -97(t0)
	addw t2, t2, t2
	ld t2, -1472(s0)
	addw s0, t2, t2
	ld t2, -1280(s0)
	ld t2, -728(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -137(t0)
	addw t2, t2, t2
	ld t2, -336(s0)
	addw s0, t2, t2
	ld t2, -464(s0)
	ld t2, -904(s0)
	mulw t2, t2, t2
	ld t2, -1600(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -257(t0)
	addw t2, t2, t2
	ld t2, -1328(s0)
	addw t2, t2, t2
	ld t2, -424(s0)
	ld t2, -768(s0)
	mulw s0, t2, t2
	addw s0, s0, t2
	ld t2, -33(t0)
	mulw t2, t4, t2
	ld t2, -305(t0)
	mulw t2, t2, t2
	ld t2, -72(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -184(s0)
	ld t2, -640(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -17(t0)
	addw s0, t2, t2
	ld t2, -1464(s0)
	ld t2, -1816(s0)
	mulw t2, t2, t2
	ld t2, -1512(s0)
	mulw t2, t2, t2
	ld t2, -904(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -504(s0)
	ld t2, -40(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -1560(s0)
	addw t2, t2, t2
	ld t2, -1680(s0)
	addw t2, t2, t2
	ld t2, -225(t0)
	addw t2, t2, t2
	ld t2, -177(t0)
	addw t2, t2, t2
	ld t2, -1008(s0)
	addw t2, t2, t2
	ld t2, -17(t0)
	mulw s0, t4, t2
	addw t2, s0, t2
	ld t2, -840(s0)
	addw s0, t2, t2
	ld t2, -520(s0)
	ld t2, -992(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1984(s0)
	addw t2, t2, t2
	ld t2, -920(s0)
	addw t2, t2, t2
	ld t2, -200(s0)
	addw s0, t2, t2
	ld t2, -121(t0)
	mulw t2, t2, s2
	ld t2, -48(s0)
	mulw t2, t2, t2
	ld t2, -1752(s0)
	mulw t2, t2, t2
	ld t2, -105(t0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1776(s0)
	ld t2, -488(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -305(t0)
	ld t2, -928(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -313(t0)
	addw t2, t2, t2
	ld t2, -1608(s0)
	ld t2, -1456(s0)
	mulw s0, t2, t2
	ld t2, -1336(s0)
	mulw s0, t2, s0
	addw s0, s0, t2
	ld t2, -1824(s0)
	ld t2, -960(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -368(s0)
	mulw t2, t2, s10
	ld t2, -1896(s0)
	mulw t2, t2, t2
	mulw t2, s7, t2
	addw t2, t2, s0
	ld t2, -1552(s0)
	ld t2, -144(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -129(t0)
	ld t2, -984(s0)
	mulw s0, t2, t2
	ld t2, -256(s0)
	mulw s0, t2, s0
	addw t2, s0, t2
	ld t2, -1128(s0)
	addw t2, t2, t2
	ld t2, -152(s0)
	addw t2, t2, t2
	ld t2, -392(s0)
	addw t2, t2, t2
	ld t2, -81(t0)
	ld t2, -776(s0)
	mulw s0, t2, t2
	addw s0, s0, t2
	ld t2, -336(s0)
	ld t2, -1080(s0)
	mulw t2, t2, t2
	ld t2, -1248(s0)
	mulw t2, t2, t2
	ld t2, -160(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -664(s0)
	addw s0, t2, t2
	ld t2, -384(s0)
	ld t2, -64(s0)
	mulw t2, t2, t2
	ld t2, -281(t0)
	mulw t2, t2, t2
	ld t2, -1008(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1768(s0)
	ld t2, -1200(s0)
	mulw t2, t2, t2
	ld t2, -648(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1152(s0)
	ld t2, -736(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -752(s0)
	addw t2, t2, t2
	ld t2, -1120(s0)
	addw t2, t2, t2
	ld t2, -416(s0)
	addw s0, t2, t2
	ld t2, -24(s0)
	ld t2, -952(s0)
	mulw t2, t2, t2
	ld t2, -680(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1048(s0)
	addw t2, t2, t2
	ld t2, -96(s0)
	addw t2, t2, t2
	ld t2, -1304(s0)
	addw t2, t2, t2
	ld t2, -328(s0)
	addw t2, t2, t2
	ld t2, -1056(s0)
	addw s0, t2, t2
	ld t2, -1792(s0)
	ld t2, -456(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -584(s0)
	ld t2, -872(s0)
	mulw t2, t2, t2
	ld t2, -1840(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -1680(s0)
	ld t2, -816(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -1880(s0)
	ld t2, -720(s0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -73(t0)
	ld t2, -329(t0)
	mulw s0, t2, t2
	addw t2, s0, t2
	ld t2, -344(s0)
	addw s0, t2, t2
	ld t2, -912(s0)
	ld t2, -784(s0)
	mulw t2, t2, t2
	ld t2, -336(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -1552(s0)
	mulw t2, t2, t3
	addw t2, t2, s0
	ld t2, -72(s0)
	addw s0, t2, t2
	ld t2, -176(s0)
	mulw t2, t3, t2
	addw t2, t2, s0
	ld t2, -1728(s0)
	ld t2, -1936(s0)
	mulw s0, t2, t2
	ld t2, -792(s0)
	mulw s0, s0, t2
	addw t2, s0, t2
	ld t2, -1480(s0)
	addw s0, t2, t2
	ld t2, -1248(s0)
	ld t2, -328(s0)
	mulw t2, t2, t2
	ld t2, -1168(s0)
	mulw t2, t2, t2
	addw s0, t2, s0
	ld t2, -480(s0)
	mulw t2, a4, t2
	addw t2, t2, s0
	ld t2, -265(t0)
	ld t2, -1112(s0)
	mulw s0, t2, t2
	addw s0, s0, t2
	ld t2, -1848(s0)
	mulw t2, t2, s1
	mulw t2, t2, s4
	addw s0, t2, s0
	ld t2, -1584(s0)
	ld t2, -129(t0)
	mulw t2, t2, t2
	ld t2, -1616(s0)
	mulw t2, t2, t2
	ld t2, -249(t0)
	mulw t2, t2, t2
	ld t2, -1632(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -624(s0)
	addw t2, t2, t2
	ld t2, -1136(s0)
	addw s0, t2, t2
	ld t2, -1152(s0)
	mulw t2, a7, t2
	ld t2, -224(s0)
	mulw t2, t2, t2
	ld t2, -1360(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -120(s0)
	ld t2, -272(s0)
	mulw s0, t2, t2
	ld t2, -1640(s0)
	mulw s0, t2, s0
	addw t2, s0, t2
	ld t2, -240(s0)
	addw t2, t2, t2
	ld t2, -1456(s0)
	addw s0, t2, t2
	ld t2, -1664(s0)
	ld t2, -232(s0)
	mulw t2, t2, t2
	addw t2, t2, s0
	ld t2, -209(t0)
	addw t2, t2, t2
	ld t2, -2008(s0)
	addw t2, t2, t2
	ld t2, -352(s0)
	addw t2, t2, t2
	ld t2, -233(t0)
	addw a0, t2, t2
	mv a0, a0
	li t0, -4096
	addiw t0, t0, -2048
	add sp, sp, t0
	ld ra, 328(sp)
	ld s0, 320(sp)
	addi sp, sp, 336
	ret 
    .size func, .-func
    .align  1
    .globl  main
    .type  main, @function
main:
.LBB2:
	addi sp, sp, -640
	sd ra, 632(sp)
	sd s0, 624(sp)
	addi s0, sp, 640
	li t0, -4096
	addiw t0, t0, -2048
	add sp, sp, t0
	li t0, 9
	sw t0, 0(sp)
	sw zero, 4(sp)
	li t0, 4
	sw t0, 8(sp)
	li t0, 4
	sw t0, 12(sp)
	li t0, 8
	sw t0, 16(sp)
	li t0, 5
	sw t0, 20(sp)
	li t0, 3
	sw t0, 24(sp)
	li t0, 1
	sw t0, 28(sp)
	li t0, 7
	sw t0, 32(sp)
	li t0, 8
	sw t0, 36(sp)
	li t0, 7
	sw t0, 40(sp)
	li t0, 2
	sw t0, 44(sp)
	li t0, 2
	sw t0, 48(sp)
	li t0, 9
	sw t0, 52(sp)
	li t0, 3
	sw t0, 56(sp)
	li t0, 4
	sw t0, 60(sp)
	li t0, 7
	sw t0, 64(sp)
	sw zero, 68(sp)
	sw zero, 72(sp)
	li t0, 9
	sw t0, 76(sp)
	li t0, 2
	sw t0, 80(sp)
	li t0, 9
	sw t0, 84(sp)
	sw zero, 88(sp)
	li t0, 9
	sw t0, 92(sp)
	li t0, 9
	sw t0, 96(sp)
	li t0, 8
	sw t0, 100(sp)
	li t0, 7
	sw t0, 104(sp)
	li t0, 4
	sw t0, 108(sp)
	li t0, 8
	sw t0, 112(sp)
	li t0, 5
	sw t0, 116(sp)
	li t0, 9
	sw t0, 120(sp)
	li t0, 1
	sw t0, 124(sp)
	li t0, 8
	sw t0, 128(sp)
	li t0, 9
	sw t0, 132(sp)
	li t0, 2
	sw t0, 136(sp)
	li t0, 3
	sw t0, 140(sp)
	li t0, 7
	sw t0, 144(sp)
	li t0, 7
	sw t0, 148(sp)
	li t0, 6
	sw t0, 152(sp)
	li t0, 8
	sw t0, 156(sp)
	li t0, 6
	sw t0, 160(sp)
	li t0, 9
	sw t0, 164(sp)
	li t0, 1
	sw t0, 168(sp)
	li t0, 3
	sw t0, 172(sp)
	li t0, 8
	sw t0, 176(sp)
	li t0, 3
	sw t0, 180(sp)
	li t0, 7
	sw t0, 184(sp)
	li t0, 5
	sw t0, 188(sp)
	li t0, 3
	sw t0, 192(sp)
	li t0, 1
	sw t0, 196(sp)
	li t0, 3
	sw t0, 200(sp)
	sw zero, 204(sp)
	li t0, 6
	sw t0, 208(sp)
	sw zero, 212(sp)
	li t0, 4
	sw t0, 216(sp)
	li t0, 3
	sw t0, 220(sp)
	li t0, 7
	sw t0, 224(sp)
	li t0, 9
	sw t0, 228(sp)
	li t0, 4
	sw t0, 232(sp)
	li t0, 7
	sw t0, 236(sp)
	li t0, 4
	sw t0, 240(sp)
	sw zero, 244(sp)
	li t0, 2
	sw t0, 248(sp)
	li t0, 6
	sw t0, 252(sp)
	li t0, 1
	sw t0, 256(sp)
	li t0, 5
	sw t0, 260(sp)
	li t0, 3
	sw t0, 264(sp)
	sw zero, 268(sp)
	sw zero, 272(sp)
	sw zero, 276(sp)
	li t0, 3
	sw t0, 280(sp)
	li t0, 3
	sw t0, 284(sp)
	li t0, 4
	sw t0, 288(sp)
	li t0, 5
	sw t0, 292(sp)
	sw zero, 296(sp)
	li t0, 9
	sw t0, 300(sp)
	li t0, 7
	sw t0, 304(sp)
	li t0, 9
	sw t0, 308(sp)
	li t0, 7
	sw t0, 312(sp)
	li t0, 5
	sw t0, 316(sp)
	li t0, 1
	sw t0, 320(sp)
	li t0, 5
	sw t0, 324(sp)
	li t0, 5
	sw t0, 328(sp)
	li t0, 9
	sw t0, 332(sp)
	li t0, 2
	sw t0, 336(sp)
	li t0, 3
	sw t0, 340(sp)
	li t0, 7
	sw t0, 344(sp)
	li t0, 6
	sw t0, 348(sp)
	li t0, 5
	sw t0, 352(sp)
	li t0, 8
	sw t0, 356(sp)
	li t0, 8
	sw t0, 360(sp)
	li t0, 5
	sw t0, 364(sp)
	li t0, 7
	sw t0, 368(sp)
	li t0, 3
	sw t0, 372(sp)
	li t0, 8
	sw t0, 376(sp)
	li t0, 7
	sw t0, 380(sp)
	li t0, 9
	sw t0, 384(sp)
	li t0, 9
	sw t0, 388(sp)
	sw zero, 392(sp)
	li t0, 4
	sw t0, 396(sp)
	li t0, 2
	sw t0, 400(sp)
	li t0, 6
	sw t0, 404(sp)
	li t0, 7
	sw t0, 408(sp)
	li t0, 3
	sw t0, 412(sp)
	li t0, 1
	sw t0, 416(sp)
	li t0, 3
	sw t0, 420(sp)
	li t0, 2
	sw t0, 424(sp)
	li t0, 5
	sw t0, 428(sp)
	li t0, 8
	sw t0, 432(sp)
	li t0, 1
	sw t0, 436(sp)
	li t0, 2
	sw t0, 440(sp)
	li t0, 3
	sw t0, 444(sp)
	li t0, 6
	sw t0, 448(sp)
	li t0, 7
	sw t0, 452(sp)
	li t0, 8
	sw t0, 456(sp)
	li t0, 3
	sw t0, 460(sp)
	li t0, 8
	sw t0, 464(sp)
	li t0, 3
	sw t0, 468(sp)
	li t0, 4
	sw t0, 472(sp)
	li t0, 6
	sw t0, 476(sp)
	li t0, 4
	sw t0, 480(sp)
	li t0, 1
	sw t0, 484(sp)
	li t0, 9
	sw t0, 488(sp)
	li t0, 4
	sw t0, 492(sp)
	li t0, 7
	sw t0, 496(sp)
	sw zero, 500(sp)
	li t0, 4
	sw t0, 504(sp)
	li t0, 3
	sw t0, 508(sp)
	li t0, 4
	sw t0, 512(sp)
	li t0, 7
	sw t0, 516(sp)
	li t0, 3
	sw t0, 520(sp)
	li t0, 9
	sw t0, 524(sp)
	li t0, 7
	sw t0, 528(sp)
	li t0, 2
	sw t0, 532(sp)
	li t0, 1
	sw t0, 536(sp)
	li t0, 1
	sw t0, 540(sp)
	li t0, 5
	sw t0, 544(sp)
	li t0, 8
	sw t0, 548(sp)
	li t0, 9
	sw t0, 552(sp)
	li t0, 1
	sw t0, 556(sp)
	li t0, 8
	sw t0, 560(sp)
	li t0, 8
	sw t0, 564(sp)
	li t0, 3
	sw t0, 568(sp)
	li t0, 9
	sw t0, 572(sp)
	li t0, 9
	sw t0, 576(sp)
	li t0, 2
	sw t0, 580(sp)
	li t0, 3
	sw t0, 584(sp)
	li t0, 2
	sw t0, 588(sp)
	li t0, 6
	sw t0, 592(sp)
	li t0, 9
	sw t0, 596(sp)
	li t0, 3
	sw t0, 600(sp)
	li t0, 1
	sw t0, 604(sp)
	li t0, 9
	sw t0, 608(sp)
	li t0, 2
	sw t0, 612(sp)
	li t0, 8
	sw t0, 616(sp)
	li t0, 3
	sw t0, 620(sp)
	sw zero, 624(sp)
	li t0, 2
	sw t0, 628(sp)
	li t0, 5
	sw t0, 632(sp)
	li t0, 2
	sw t0, 636(sp)
	li t0, 1
	sw t0, 640(sp)
	li t0, 6
	sw t0, 644(sp)
	li t0, 6
	sw t0, 648(sp)
	li t0, 9
	sw t0, 652(sp)
	li t0, 8
	sw t0, 656(sp)
	li t0, 6
	sw t0, 660(sp)
	li t0, 6
	sw t0, 664(sp)
	li t0, 7
	sw t0, 668(sp)
	li t0, 4
	sw t0, 672(sp)
	li t0, 6
	sw t0, 676(sp)
	li t0, 9
	sw t0, 680(sp)
	li t0, 4
	sw t0, 684(sp)
	li t0, 1
	sw t0, 688(sp)
	li t0, 9
	sw t0, 692(sp)
	li t0, 1
	sw t0, 696(sp)
	li t0, 3
	sw t0, 700(sp)
	sw zero, 704(sp)
	li t0, 9
	sw t0, 708(sp)
	li t0, 5
	sw t0, 712(sp)
	li t0, 8
	sw t0, 716(sp)
	li t0, 8
	sw t0, 720(sp)
	li t0, 2
	sw t0, 724(sp)
	li t0, 6
	sw t0, 728(sp)
	li t0, 5
	sw t0, 732(sp)
	li t0, 6
	sw t0, 736(sp)
	li t0, 4
	sw t0, 740(sp)
	li t0, 7
	sw t0, 744(sp)
	li t0, 6
	sw t0, 748(sp)
	li t0, 1
	sw t0, 752(sp)
	li t0, 3
	sw t0, 756(sp)
	li t0, 8
	sw t0, 760(sp)
	li t0, 6
	sw t0, 764(sp)
	li t0, 7
	sw t0, 768(sp)
	li t0, 8
	sw t0, 772(sp)
	sw zero, 776(sp)
	li t0, 9
	sw t0, 780(sp)
	li t0, 4
	sw t0, 784(sp)
	li t0, 7
	sw t0, 788(sp)
	li t0, 7
	sw t0, 792(sp)
	li t0, 9
	sw t0, 796(sp)
	li t0, 8
	sw t0, 800(sp)
	li t0, 8
	sw t0, 804(sp)
	li t0, 6
	sw t0, 808(sp)
	li t0, 6
	sw t0, 812(sp)
	li t0, 2
	sw t0, 816(sp)
	li t0, 5
	sw t0, 820(sp)
	li t0, 7
	sw t0, 824(sp)
	li t0, 7
	sw t0, 828(sp)
	li t0, 6
	sw t0, 832(sp)
	li t0, 9
	sw t0, 836(sp)
	li t0, 2
	sw t0, 840(sp)
	li t0, 8
	sw t0, 844(sp)
	sw zero, 848(sp)
	li t0, 7
	sw t0, 852(sp)
	li t0, 4
	sw t0, 856(sp)
	sw zero, 860(sp)
	li t0, 5
	sw t0, 864(sp)
	li t0, 2
	sw t0, 868(sp)
	li t0, 8
	sw t0, 872(sp)
	li t0, 5
	sw t0, 876(sp)
	li t0, 9
	sw t0, 880(sp)
	li t0, 2
	sw t0, 884(sp)
	li t0, 2
	sw t0, 888(sp)
	li t0, 1
	sw t0, 892(sp)
	li t0, 8
	sw t0, 896(sp)
	sw zero, 900(sp)
	li t0, 9
	sw t0, 904(sp)
	li t0, 6
	sw t0, 908(sp)
	li t0, 3
	sw t0, 912(sp)
	li t0, 6
	sw t0, 916(sp)
	li t0, 9
	sw t0, 920(sp)
	li t0, 8
	sw t0, 924(sp)
	li t0, 3
	sw t0, 928(sp)
	li t0, 7
	sw t0, 932(sp)
	li t0, 2
	sw t0, 936(sp)
	li t0, 2
	sw t0, 940(sp)
	sw zero, 944(sp)
	li t0, 1
	sw t0, 948(sp)
	li t0, 2
	sw t0, 952(sp)
	li t0, 9
	sw t0, 956(sp)
	li t0, 2
	sw t0, 960(sp)
	li t0, 6
	sw t0, 964(sp)
	li t0, 4
	sw t0, 968(sp)
	li t0, 5
	sw t0, 972(sp)
	li t0, 2
	sw t0, 976(sp)
	sw zero, 980(sp)
	li t0, 9
	sw t0, 984(sp)
	li t0, 8
	sw t0, 988(sp)
	li t0, 7
	sw t0, 992(sp)
	li t0, 6
	sw t0, 996(sp)
	sw zero, 1000(sp)
	sw zero, 1004(sp)
	li t0, 7
	sw t0, 1008(sp)
	li t0, 1
	sw t0, 1012(sp)
	li t0, 7
	sw t0, 1016(sp)
	li t0, 2
	sw t0, 1020(sp)
	li t0, 3
	sw t0, 1024(sp)
	li t0, 1
	sw t0, 1028(sp)
	li t0, 7
	sw t0, 1032(sp)
	li t0, 2
	sw t0, 1036(sp)
	sw zero, 1040(sp)
	li t0, 4
	sw t0, 1044(sp)
	li t0, 7
	sw t0, 1048(sp)
	li t0, 3
	sw t0, 1052(sp)
	li t0, 5
	sw t0, 1056(sp)
	li t0, 4
	sw t0, 1060(sp)
	li t0, 9
	sw t0, 1064(sp)
	li t0, 4
	sw t0, 1068(sp)
	li t0, 5
	sw t0, 1072(sp)
	li t0, 1
	sw t0, 1076(sp)
	li t0, 9
	sw t0, 1080(sp)
	li t0, 2
	sw t0, 1084(sp)
	sw zero, 1088(sp)
	li t0, 3
	sw t0, 1092(sp)
	li t0, 8
	sw t0, 1096(sp)
	li t0, 7
	sw t0, 1100(sp)
	li t0, 5
	sw t0, 1104(sp)
	li t0, 8
	sw t0, 1108(sp)
	li t0, 1
	sw t0, 1112(sp)
	sw zero, 1116(sp)
	li t0, 7
	sw t0, 1120(sp)
	li t0, 6
	sw t0, 1124(sp)
	li t0, 9
	sw t0, 1128(sp)
	li t0, 5
	sw t0, 1132(sp)
	li t0, 2
	sw t0, 1136(sp)
	li t0, 7
	sw t0, 1140(sp)
	li t0, 3
	sw t0, 1144(sp)
	li t0, 3
	sw t0, 1148(sp)
	li t0, 2
	sw t0, 1152(sp)
	li t0, 8
	sw t0, 1156(sp)
	li t0, 5
	sw t0, 1160(sp)
	li t0, 4
	sw t0, 1164(sp)
	li t0, 8
	sw t0, 1168(sp)
	li t0, 8
	sw t0, 1172(sp)
	sw zero, 1176(sp)
	li t0, 2
	sw t0, 1180(sp)
	li t0, 2
	sw t0, 1184(sp)
	sw zero, 1188(sp)
	li t0, 9
	sw t0, 1192(sp)
	sw zero, 1196(sp)
	li t0, 3
	sw t0, 1200(sp)
	li t0, 4
	sw t0, 1204(sp)
	li t0, 9
	sw t0, 1208(sp)
	li t0, 6
	sw t0, 1212(sp)
	li t0, 3
	sw t0, 1216(sp)
	li t0, 1
	sw t0, 1220(sp)
	li t0, 4
	sw t0, 1224(sp)
	li t0, 3
	sw t0, 1228(sp)
	li t0, 6
	sw t0, 1232(sp)
	li t0, 3
	sw t0, 1236(sp)
	li t0, 6
	sw t0, 1240(sp)
	li t0, 2
	sw t0, 1244(sp)
	li t0, 4
	sw t0, 1248(sp)
	li t0, 3
	sw t0, 1252(sp)
	li t0, 5
	sw t0, 1256(sp)
	sw zero, 1260(sp)
	li t0, 6
	sw t0, 1264(sp)
	li t0, 1
	sw t0, 1268(sp)
	li t0, 7
	sw t0, 1272(sp)
	li t0, 7
	sw t0, 1276(sp)
	li t0, 6
	sw t0, 1280(sp)
	li t0, 6
	sw t0, 1284(sp)
	li t0, 9
	sw t0, 1288(sp)
	li t0, 8
	sw t0, 1292(sp)
	li t0, 7
	sw t0, 1296(sp)
	li t0, 7
	sw t0, 1300(sp)
	sw zero, 1304(sp)
	li t0, 4
	sw t0, 1308(sp)
	sw zero, 1312(sp)
	li t0, 2
	sw t0, 1316(sp)
	li t0, 4
	sw t0, 1320(sp)
	li t0, 5
	sw t0, 1324(sp)
	li t0, 7
	sw t0, 1328(sp)
	li t0, 8
	sw t0, 1332(sp)
	li t0, 2
	sw t0, 1336(sp)
	li t0, 8
	sw t0, 1340(sp)
	li t0, 8
	sw t0, 1344(sp)
	li t0, 1
	sw t0, 1348(sp)
	li t0, 8
	sw t0, 1352(sp)
	li t0, 3
	sw t0, 1356(sp)
	li t0, 6
	sw t0, 1360(sp)
	li t0, 9
	sw t0, 1364(sp)
	li t0, 1
	sw t0, 1368(sp)
	li t0, 7
	sw t0, 1372(sp)
	li t0, 6
	sw t0, 1376(sp)
	li t0, 9
	sw t0, 1380(sp)
	li t0, 3
	sw t0, 1384(sp)
	li t0, 7
	sw t0, 1388(sp)
	li t0, 5
	sw t0, 1392(sp)
	li t0, 8
	sw t0, 1396(sp)
	li t0, 3
	sw t0, 1400(sp)
	li t0, 9
	sw t0, 1404(sp)
	li t0, 2
	sw t0, 1408(sp)
	li t0, 1
	sw t0, 1412(sp)
	li t0, 3
	sw t0, 1416(sp)
	li t0, 2
	sw t0, 1420(sp)
	li t0, 9
	sw t0, 1424(sp)
	sw zero, 1428(sp)
	li t0, 7
	sw t0, 1432(sp)
	li t0, 3
	sw t0, 1436(sp)
	li t0, 1
	sw t0, 1440(sp)
	li t0, 3
	sw t0, 1444(sp)
	li t0, 7
	sw t0, 1448(sp)
	li t0, 9
	sw t0, 1452(sp)
	sw zero, 1456(sp)
	li t0, 6
	sw t0, 1460(sp)
	li t0, 8
	sw t0, 1464(sp)
	sw zero, 1468(sp)
	li t0, 3
	sw t0, 1472(sp)
	li t0, 2
	sw t0, 1476(sp)
	li t0, 4
	sw t0, 1480(sp)
	li t0, 9
	sw t0, 1484(sp)
	li t0, 3
	sw t0, 1488(sp)
	li t0, 1
	sw t0, 1492(sp)
	li t0, 6
	sw t0, 1496(sp)
	li t0, 4
	sw t0, 1500(sp)
	li t0, 9
	sw t0, 1504(sp)
	li t0, 7
	sw t0, 1508(sp)
	li t0, 5
	sw t0, 1512(sp)
	li t0, 8
	sw t0, 1516(sp)
	sw zero, 1520(sp)
	li t0, 5
	sw t0, 1524(sp)
	li t0, 1
	sw t0, 1528(sp)
	li t0, 5
	sw t0, 1532(sp)
	li t0, 1
	sw t0, 1536(sp)
	li t0, 4
	sw t0, 1540(sp)
	li t0, 2
	sw t0, 1544(sp)
	li t0, 6
	sw t0, 1548(sp)
	li t0, 9
	sw t0, 1552(sp)
	li t0, 1
	sw t0, 1556(sp)
	li t0, 9
	sw t0, 1560(sp)
	li t0, 9
	sw t0, 1564(sp)
	li t0, 2
	sw t0, 1568(sp)
	li t0, 6
	sw t0, 1572(sp)
	li t0, 3
	sw t0, 1576(sp)
	li t0, 3
	sw t0, 1580(sp)
	sw zero, 1584(sp)
	li t0, 6
	sw t0, 1588(sp)
	li t0, 3
	sw t0, 1592(sp)
	li t0, 5
	sw t0, 1596(sp)
	sw zero, 1600(sp)
	li t0, 1
	sw t0, 1604(sp)
	li t0, 7
	sw t0, 1608(sp)
	li t0, 5
	sw t0, 1612(sp)
	li t0, 5
	sw t0, 1616(sp)
	li t0, 8
	sw t0, 1620(sp)
	li t0, 7
	sw t0, 1624(sp)
	li t0, 3
	sw t0, 1628(sp)
	li t0, 9
	sw t0, 1632(sp)
	li t0, 6
	sw t0, 1636(sp)
	li t0, 2
	sw t0, 1640(sp)
	li t0, 4
	sw t0, 1644(sp)
	sw zero, 1648(sp)
	sw zero, 1652(sp)
	li t0, 6
	sw t0, 1656(sp)
	li t0, 4
	sw t0, 1660(sp)
	li t0, 9
	sw t0, 1664(sp)
	li t0, 4
	sw t0, 1668(sp)
	li t0, 9
	sw t0, 1672(sp)
	li t0, 4
	sw t0, 1676(sp)
	sw zero, 1680(sp)
	li t0, 5
	sw t0, 1684(sp)
	li t0, 1
	sw t0, 1688(sp)
	sw zero, 1692(sp)
	sw zero, 1696(sp)
	li t0, 2
	sw t0, 1700(sp)
	li t0, 4
	sw t0, 1704(sp)
	li t0, 9
	sw t0, 1708(sp)
	sw zero, 1712(sp)
	li t0, 5
	sw t0, 1716(sp)
	li t0, 2
	sw t0, 1720(sp)
	li t0, 5
	sw t0, 1724(sp)
	li t0, 2
	sw t0, 1728(sp)
	li t0, 9
	sw t0, 1732(sp)
	li t0, 8
	sw t0, 1736(sp)
	li t0, 5
	sw t0, 1740(sp)
	li t0, 9
	sw t0, 1744(sp)
	sw zero, 1748(sp)
	sw zero, 1752(sp)
	li t0, 4
	sw t0, 1756(sp)
	li t0, 2
	sw t0, 1760(sp)
	li t0, 3
	sw t0, 1764(sp)
	li t0, 2
	sw t0, 1768(sp)
	li t0, 5
	sw t0, 1772(sp)
	sw zero, 1776(sp)
	li t0, 4
	sw t0, 1780(sp)
	li t0, 8
	sw t0, 1784(sp)
	li t0, 5
	sw t0, 1788(sp)
	li t0, 6
	sw t0, 1792(sp)
	li t0, 8
	sw t0, 1796(sp)
	li t0, 9
	sw t0, 1800(sp)
	li t0, 6
	sw t0, 1804(sp)
	li t0, 5
	sw t0, 1808(sp)
	li t0, 7
	sw t0, 1812(sp)
	li t0, 9
	sw t0, 1816(sp)
	li t0, 2
	sw t0, 1820(sp)
	li t0, 6
	sw t0, 1824(sp)
	li t0, 3
	sw t0, 1828(sp)
	li t0, 4
	sw t0, 1832(sp)
	li t0, 8
	sw t0, 1836(sp)
	li t0, 9
	sw t0, 1840(sp)
	li t0, 6
	sw t0, 1844(sp)
	sw zero, 1848(sp)
	li t0, 6
	sw t0, 1852(sp)
	sw zero, 1856(sp)
	li t0, 9
	sw t0, 1860(sp)
	li t0, 1
	sw t0, 1864(sp)
	li t0, 7
	sw t0, 1868(sp)
	li t0, 4
	sw t0, 1872(sp)
	li t0, 9
	sw t0, 1876(sp)
	li t0, 9
	sw t0, 1880(sp)
	li t0, 7
	sw t0, 1884(sp)
	li t0, 4
	sw t0, 1888(sp)
	li t0, 3
	sw t0, 1892(sp)
	li t0, 7
	sw t0, 1896(sp)
	li t0, 4
	sw t0, 1900(sp)
	li t0, 2
	sw t0, 1904(sp)
	li t0, 9
	sw t0, 1908(sp)
	li t0, 8
	sw t0, 1912(sp)
	li t0, 1
	sw t0, 1916(sp)
	li t0, 5
	sw t0, 1920(sp)
	li t0, 8
	sw t0, 1924(sp)
	li t0, 9
	sw t0, 1928(sp)
	li t0, 8
	sw t0, 1932(sp)
	li t0, 7
	sw t0, 1936(sp)
	sw zero, 1940(sp)
	li t0, 9
	sw t0, 1944(sp)
	li t0, 9
	sw t0, 1948(sp)
	sw zero, 1952(sp)
	li t0, 6
	sw t0, 1956(sp)
	li t0, 6
	sw t0, 1960(sp)
	sw zero, 1964(sp)
	li t0, 4
	sw t0, 1968(sp)
	li t0, 2
	sw t0, 1972(sp)
	li t0, 1
	sw t0, 1976(sp)
	li t0, 7
	sw t0, 1980(sp)
	li t0, 1
	sw t0, 1984(sp)
	li t0, 2
	sw t0, 1988(sp)
	li t0, 2
	sw t0, 1992(sp)
	li t0, 7
	sw t0, 1996(sp)
	li t0, 3
	sw t0, 2000(sp)
	li t0, 2
	sw t0, 2004(sp)
	li t0, 1
	sw t0, 2008(sp)
	li t0, 8
	sw t0, 2012(sp)
	li t0, 9
	sw t0, 2016(sp)
	li t0, 9
	sw t0, 2020(sp)
	li t0, 2
	sw t0, 2024(sp)
	li t0, 4
	sw t0, 2028(sp)
	li t0, 4
	sw t0, 2032(sp)
	li t0, 2
	sw t0, 2036(sp)
	li t0, 8
	sw t0, 2040(sp)
	li t0, 9
	sw t0, 2044(sp)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 1(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 5(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 9(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 13(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 17(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 21(t0)
	addiw t0, sp, 2047
	sw zero, 25(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 29(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 33(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 37(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 41(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 45(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 49(t0)
	addiw t0, sp, 2047
	sw zero, 53(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 57(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 61(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 65(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 69(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 73(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 77(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 81(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 85(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 89(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 93(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 97(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 101(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 105(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 109(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 113(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 117(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 121(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 125(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 129(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 133(t0)
	li t0, 1
	addiw t0, sp, 2047
	sw t0, 137(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 141(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 145(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 149(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 153(t0)
	addiw t0, sp, 2047
	sw zero, 157(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 161(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 165(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 169(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 173(t0)
	addiw t0, sp, 2047
	sw zero, 177(t0)
	addiw t0, sp, 2047
	sw zero, 181(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 185(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 189(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 193(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 197(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 201(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 205(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 209(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 213(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 217(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 221(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 225(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 229(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 233(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 237(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 241(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 245(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 249(t0)
	addiw t0, sp, 2047
	sw zero, 253(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 257(t0)
	addiw t0, sp, 2047
	sw zero, 261(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 265(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 269(t0)
	addiw t0, sp, 2047
	sw zero, 273(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 277(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 281(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 285(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 289(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 293(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 297(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 301(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 305(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 309(t0)
	li t0, 1
	addiw t0, sp, 2047
	sw t0, 313(t0)
	li t0, 1
	addiw t0, sp, 2047
	sw t0, 317(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 321(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 325(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 329(t0)
	addiw t0, sp, 2047
	sw zero, 333(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 337(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 341(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 345(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 349(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 353(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 357(t0)
	addiw t0, sp, 2047
	sw zero, 361(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 365(t0)
	addiw t0, sp, 2047
	sw zero, 369(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 373(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 377(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 381(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 385(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 389(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 393(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 397(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 401(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 405(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 409(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 413(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 417(t0)
	addiw t0, sp, 2047
	sw zero, 421(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 425(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 429(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 433(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 437(t0)
	addiw t0, sp, 2047
	sw zero, 441(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 445(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 449(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 453(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 457(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 461(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 465(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 469(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 473(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 477(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 481(t0)
	addiw t0, sp, 2047
	sw zero, 485(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 489(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 493(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 497(t0)
	li t0, 1
	addiw t0, sp, 2047
	sw t0, 501(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 505(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 509(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 513(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 517(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 521(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 525(t0)
	li t0, 1
	addiw t0, sp, 2047
	sw t0, 529(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 533(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 537(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 541(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 545(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 549(t0)
	addiw t0, sp, 2047
	sw zero, 553(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 557(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 561(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 565(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 569(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 573(t0)
	li t0, 8
	addiw t0, sp, 2047
	sw t0, 577(t0)
	addiw t0, sp, 2047
	sw zero, 581(t0)
	li t0, 5
	addiw t0, sp, 2047
	sw t0, 585(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 589(t0)
	li t0, 3
	addiw t0, sp, 2047
	sw t0, 593(t0)
	li t0, 9
	addiw t0, sp, 2047
	sw t0, 597(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 601(t0)
	li t0, 1
	addiw t0, sp, 2047
	sw t0, 605(t0)
	li t0, 7
	addiw t0, sp, 2047
	sw t0, 609(t0)
	li t0, 4
	addiw t0, sp, 2047
	sw t0, 613(t0)
	li t0, 2
	addiw t0, sp, 2047
	sw t0, 617(t0)
	li t0, 6
	addiw t0, sp, 2047
	sw t0, 621(t0)
	li a0, 0
	li a1, 1
	li a2, 1
	li a3, 8
	li a4, 9
	li a5, 5
	li a6, 2
	li a7, 9
	call func
	mv a0, a0
	mv a0, a0
	li t0, -4096
	addiw t0, t0, -2048
	add sp, sp, t0
	ld ra, 632(sp)
	ld s0, 624(sp)
	addi sp, sp, 640
	ret 
    .size main, .-main
