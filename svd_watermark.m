%水印编码过程
I=imread('lena.bmp');
W=imread('mark.jpg');
W=rgb2gray(W);    %若采用其他不同大小的图片作为水印嵌入，可使用这两行代码
W=imresize(W,[256,256]); %大小须与目标图像一致
[U,S,V]=svd(double(I));
a=0.1;   %水印强度参数
L=S+a*double(W);
[U1,S1,V1]=svd(L);
J=U*S1*V';

%水印解码过程
[U2,S2,V2]=svd(J);
F=U1*S2*V1';
We=(F-S)/0.1;

figure
subplot(2,2,1),imshow(I),title('原始图像');
subplot(2,2,2),imshow(W),title('加入的水印图像');
subplot(2,2,3),imshow(uint8(J)),title('加入水印后的图像');
subplot(2,2,4),imshow(uint8(We)),title('检测出的水印图像');
