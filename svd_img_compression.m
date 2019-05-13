rou=input('������ѹ���Ȧѣ�');
%rou=1.5;
n=256; %ͼ���СΪn*n
k=n*n/(rou*(2*n+1)); %��������ֵ�ĸ���
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
subplot(1,2,1),imshow(I),title('ԭʼͼ��');
subplot(1,2,2),imshow(K),title('ѹ����Ϊ16��ѹ��ͼ��');

%����MSE��PSNR
[m,n]=size(I);
MSE = sum(( double(I(:)) - double(K(:)) ).^2);
MSE = MSE/(m*n);
%a=reshape(double(I),65536,1); %�������㷨
%b=reshape(double(K),65536,1);%x=a-b;
%MSE=(1/65536)*(norm(x,2))*(norm(x,2));
PSNR=10*log10((255*255)/MSE);
display(MSE);display(PSNR);


    