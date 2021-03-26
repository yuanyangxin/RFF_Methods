function gray(newbuf,show_Img)
min_n=min(min(newbuf));  
max_n=max(max(newbuf));  
newbuf=newbuf./(max_n-min_n)*255;  
[M,N]=size(newbuf);  
for i=1:1:M  
    for j=1:1:N  
        R(i,j)=newbuf(i,j);  
        G(i,j)=newbuf(i,j);  
        B(i,j)=newbuf(i,j);  
    end  
end  
img(1:1:M,1:1:N,1)=R(1:M,1:N);  
img(1:1:M,1:1:N,2)=G(1:M,1:N);  
img(1:1:M,1:1:N,3)=B(1:M,1:N);  
if(show_Img == 1)
    imshow(uint8(img));  
end
imwrite(uint8(img), 'u1.jpg');


function r=GrayColorR(gray)  
r=0;  
if gray>=170  
    r=255;  
end  
if gray>=128&&gray<=170  
    r=255/42*(gray-128);  
end  
return;  
function g=GrayColorG(gray)  
g=0;  
if gray>=84&&gray<=170  
    g=255;  
end  
if gray<=84  
    g=255/84*gray;  
end  
if gray>=170&&gray<=255  
    g=255/85*(255-gray);  
end  
return;  
function b=GrayColorB(gray)  
b=0;  
if gray<=84  
    b=255;  
end  
if gray>=84&&gray<=128  
    b=255/44*(128-gray);  
end  
return;  

