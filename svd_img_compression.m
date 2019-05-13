rou=input('请输入压缩比ρ：');
%rou=1.5;
n=256; %图像大小为n*n
k=n*n/(rou*(2*n+1)); %保留奇异值的个数
display(k);

I=imread('lena.bmp');
J=double(I);
[U,S,V]=svd(J);
u=zeros(256,1);
v=zeros(256,1);
K=zeros(256,256);
k=uint8(k); 

for i=1:k
    s=S(i,i);
    u=U(:,i);
    v=V(:,i);
    K=K+s*(u*v');
end
K=uint8(K);
figure
subplot(1,2,1),imshow(I),title('原始图像');
subplot(1,2,2),imshow(K),title('压缩比为ρ的压缩图像');

%计算MSE和PSNR
[m,n]=size(I);
MSE = sum(( double(I(:)) - double(K(:)) ).^2);
MSE = MSE/(m*n);
%a=reshape(double(I),65536,1); %向量化算法
%b=reshape(double(K),65536,1);%x=a-b;
%MSE=(1/65536)*(norm(x,2))*(norm(x,2));
PSNR=10*log10((255*255)/MSE);
display(MSE);display(PSNR);


    
