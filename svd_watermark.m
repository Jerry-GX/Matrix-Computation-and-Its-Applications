%ˮӡ�������
I=imread('lena.bmp');
W=imread('mark.jpg');
W=rgb2gray(W);    %������������ͬ��С��ͼƬ��ΪˮӡǶ�룬��ʹ�������д���
W=imresize(W,[256,256]); %��С����Ŀ��ͼ��һ��
[U,S,V]=svd(double(I));
a=0.1;   %ˮӡǿ�Ȳ���
L=S+a*double(W);
[U1,S1,V1]=svd(L);
J=U*S1*V';

%ˮӡ�������
[U2,S2,V2]=svd(J);
F=U1*S2*V1';
We=(F-S)/0.1;

figure
subplot(2,2,1),imshow(I),title('ԭʼlenaͼ��');
subplot(2,2,2),imshow(W),title('�����ˮӡͼ��');
subplot(2,2,3),imshow(uint8(J)),title('����ˮӡ���lenaͼ�� a=0.1');
subplot(2,2,4),imshow(uint8(We)),title('������ˮӡͼ��a=0.1');


%H=[1+1i,3+1i,7;5-0.1i,4+1i,8-1i;2+3i,6-1i,1+3i];
%[U,S,V]=svd(H);