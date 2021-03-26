clc
clear
for i = 1:5
    for j = 1:9
        namestr = ['s' num2str(i) '_' num2str(j) '=i'];
        eval(namestr);
    end
end