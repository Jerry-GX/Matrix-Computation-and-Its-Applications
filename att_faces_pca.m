new_path='C:\att_faces\';   %240幅图像存储路径
newDir=dir(new_path);
count2=0; %计数器，用于统计参与计算的图像数量，count3同
count3=0;
Z=double(zeros(10304,240)); %初始化数据矩阵Z（包含240个图像向量）
J=zeros(112,92);

%计算240幅人脸的平均脸
for i = 1:length(newDir)
    %去除隐藏文件夹和Problem Set 3 att_faces文件夹
    if(isequal(newDir(i).name,'.')||isequal(newDir(i).name,'..')||isequal(newDir(i).name,'Problem Set 3 att_faces'))                
    continue;
    end
    img_dir=dir([new_path newDir(i).name '\*.pgm']);
    for k =1:length(img_dir)                 % 遍历所有图片
        I2 = double(imread([new_path newDir(i).name '\' img_dir(k).name]));
        J=J+I2;
        count2=count2+1;
    end
end
J=J/240;
%imshow(uint8(J));
miu=reshape(J,10304,1);  %均值向量μ

for i = 1:length(newDir)
    %去除隐藏文件夹和Problem Set 3 att_faces文件夹
    if(isequal(newDir(i).name,'.')||isequal(newDir(i).name,'..')||isequal(newDir(i).name,'Problem Set 3 att_faces'))                
    continue;
    end
    img_dir=dir([new_path newDir(i).name '\*.pgm']);
    for k =1:length(img_dir)                 % 遍历所有图片
        I2 = double(imread([new_path newDir(i).name '\' img_dir(k).name]));
        I2=reshape(I2,10304,1); %图像矩阵向量化
        z=I2-miu;   %去中心化
        count3=count3+1;
        Z(:,count3)=z;     %构造数据矩阵Z   
    end
end

%主成分分析PCA
C0=Z'*Z;
[V0,a]=eig(C0);  %矩阵C0特征分解
V=Z*V0;  %特征向量
sort_V=double(zeros(10304,240));
k=240;
for i=1:240  %将特征向量按特征值从大到小排列
    sort_V(1:10304,i)=V(1:10304,k);
    k=k-1;    
end

new_sort_V=sort_V(1:10304,1:40); %保留最大的40个特征值对应的特征向量

%显示出前15个“特征脸”图像
show_V=sort_V(1:10304,1:15);
k=1;
for i=1:112:2*112+1
     for j=1:92:4*92+1
         show_image(i:i+111,j:j+91)=reshape(new_sort_V(:,k),112,92);
         k=k+1;
     end
end

minum=min(min(show_image));%对特征向量进行0-255的映射
maxum=max(max(show_image));
d=maxum-minum;
show_image(:,:)=show_image(:,:)-minum;
show_image(:,:)=show_image(:,:)/d;
show_image(:,:)=show_image(:,:)*255;
show_image=uint8(show_image);
figure
imshow(show_image);
title('前15个“特征脸”图像');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%以下为图像重构部分
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unit_V=double(zeros(10304,40));
for i=1:40
    unit_V(:,i)=new_sort_V(:,i)/norm(new_sort_V(:,i)); %特征向量归一化为单位向量
end
path_1='C:\att_faces\Problem Set 3 att_faces\att_faces\s1\10.pgm'; %图像路径
path_2='C:\att_faces\Problem Set 3 att_faces\att_faces\s2\10.pgm';
path_3='C:\att_faces\Problem Set 3 att_faces\att_faces\s3\10.pgm';
path_4='C:\att_faces\Problem Set 3 att_faces\att_faces\s4\10.pgm';
path_5='C:\att_faces\Problem Set 3 att_faces\att_faces\s5\10.pgm';
path_6='C:\att_faces\Problem Set 3 att_faces\att_faces\s6\10.pgm';
path_7='C:\att_faces\Problem Set 3 att_faces\att_faces\s7\10.pgm';
path_8='C:\att_faces\Problem Set 3 att_faces\att_faces\s8\10.pgm';
path_9='C:\att_faces\Problem Set 3 att_faces\att_faces\s9\10.pgm';
path_10='C:\att_faces\Problem Set 3 att_faces\att_faces\s10\10.pgm';

test_1=imread(path_1);
re_1=reconstruction(path_1,miu,unit_V ); %调用重构函数reconstruction
test_2=imread(path_2);
re_2=reconstruction(path_2,miu,unit_V );
test_3=imread(path_3);
re_3=reconstruction(path_3,miu,unit_V );
test_4=imread(path_4);
re_4=reconstruction(path_4,miu,unit_V );
test_5=imread(path_5);
re_5=reconstruction(path_5,miu,unit_V );
test_6=imread(path_6);
re_6=reconstruction(path_6,miu,unit_V );
test_7=imread(path_7);
re_7=reconstruction(path_7,miu,unit_V );
test_8=imread(path_8);
re_8=reconstruction(path_8,miu,unit_V );
test_9=imread(path_9);
re_9=reconstruction(path_9,miu,unit_V );
test_10=imread(path_10);
re_10=reconstruction(path_10,miu,unit_V );

figure %对比图像展示
subplot(2,5,1),imshow(test_1),title('image 1');
subplot(2,5,2),imshow(test_2),title('image 2');
subplot(2,5,3),imshow(test_3),title('image 3');
subplot(2,5,4),imshow(test_4),title('image 4');
subplot(2,5,5),imshow(test_5),title('image 5');
subplot(2,5,6),imshow(re_1),title('reconstruction of image 1');
subplot(2,5,7),imshow(re_2),title('reconstruction of image 2');
subplot(2,5,8),imshow(re_3),title('reconstruction of image 3');
subplot(2,5,9),imshow(re_4),title('reconstruction of image 4');
subplot(2,5,10),imshow(re_5),title('reconstruction of image 5');

figure
subplot(2,5,1),imshow(test_6),title('image 6');
subplot(2,5,2),imshow(test_7),title('image 7');
subplot(2,5,3),imshow(test_8),title('image 8');
subplot(2,5,4),imshow(test_9),title('image 9');
subplot(2,5,5),imshow(test_10),title('image 10');
subplot(2,5,6),imshow(re_6),title('reconstruction of image 6');
subplot(2,5,7),imshow(re_7),title('reconstruction of image 7');
subplot(2,5,8),imshow(re_8),title('reconstruction of image 8');
subplot(2,5,9),imshow(re_9),title('reconstruction of image 9');
subplot(2,5,10),imshow(re_10),title('reconstruction of image 10');

path_1='C:\att_faces\Problem Set 3 att_faces\att_faces\s31\1.pgm';%后10位志愿者图像路径
path_2='C:\att_faces\Problem Set 3 att_faces\att_faces\s32\1.pgm';
path_3='C:\att_faces\Problem Set 3 att_faces\att_faces\s33\1.pgm';
path_4='C:\att_faces\Problem Set 3 att_faces\att_faces\s34\1.pgm';
path_5='C:\att_faces\Problem Set 3 att_faces\att_faces\s35\1.pgm';
path_6='C:\att_faces\Problem Set 3 att_faces\att_faces\s36\1.pgm';
path_7='C:\att_faces\Problem Set 3 att_faces\att_faces\s37\1.pgm';
path_8='C:\att_faces\Problem Set 3 att_faces\att_faces\s38\1.pgm';
path_9='C:\att_faces\Problem Set 3 att_faces\att_faces\s39\1.pgm';
path_10='C:\att_faces\Problem Set 3 att_faces\att_faces\s40\1.pgm';

test_1=imread(path_1);
re_1=reconstruction(path_1,miu,unit_V );
test_2=imread(path_2);
re_2=reconstruction(path_2,miu,unit_V );
test_3=imread(path_3);
re_3=reconstruction(path_3,miu,unit_V );
test_4=imread(path_4);
re_4=reconstruction(path_4,miu,unit_V );
test_5=imread(path_5);
re_5=reconstruction(path_5,miu,unit_V );
test_6=imread(path_6);
re_6=reconstruction(path_6,miu,unit_V );
test_7=imread(path_7);
re_7=reconstruction(path_7,miu,unit_V );
test_8=imread(path_8);
re_8=reconstruction(path_8,miu,unit_V );
test_9=imread(path_9);
re_9=reconstruction(path_9,miu,unit_V );
test_10=imread(path_10);
re_10=reconstruction(path_10,miu,unit_V );
figure
subplot(2,5,1),imshow(test_1),title('test image 1');
subplot(2,5,2),imshow(test_2),title('test image 2');
subplot(2,5,3),imshow(test_3),title('test image 3');
subplot(2,5,4),imshow(test_4),title('test image 4');
subplot(2,5,5),imshow(test_5),title('test image 5');
subplot(2,5,6),imshow(re_1),title('reconstruction of image 1');
subplot(2,5,7),imshow(re_2),title('reconstruction of image 2');
subplot(2,5,8),imshow(re_3),title('reconstruction of image 3');
subplot(2,5,9),imshow(re_4),title('reconstruction of image 4');
subplot(2,5,10),imshow(re_5),title('reconstruction of image 5');

figure
subplot(2,5,1),imshow(test_6),title('test image 6');
subplot(2,5,2),imshow(test_7),title('test image 7');
subplot(2,5,3),imshow(test_8),title('test image 8');
subplot(2,5,4),imshow(test_9),title('test image 9');
subplot(2,5,5),imshow(test_10),title('test image 10');
subplot(2,5,6),imshow(re_6),title('reconstruction of image 6');
subplot(2,5,7),imshow(re_7),title('reconstruction of image 7');
subplot(2,5,8),imshow(re_8),title('reconstruction of image 8');
subplot(2,5,9),imshow(re_9),title('reconstruction of image 9');
subplot(2,5,10),imshow(re_10),title('reconstruction of image 10');




