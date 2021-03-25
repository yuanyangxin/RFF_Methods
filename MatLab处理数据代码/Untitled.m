str = "F:\东大毕设\data\实验采集的数据\室外近距离_同步信号\Syn_Device_1_1";
load(str)

for i = 1:8
    plot(real(Brush_Data_Temp(160*i - 159:160*i)));
    hold on;
end