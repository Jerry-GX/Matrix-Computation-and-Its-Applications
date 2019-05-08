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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%以下为人脸识别部分
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unit_V=double(zeros(10304,40));
for i=1:40
    unit_V(:,i)=new_sort_V(:,i)/norm(new_sort_V(:,i)); %特征向量归一化为单位向量
end

path_1='C:\att_faces\Problem Set 3 att_faces\att_faces\s1\10.pgm'; %前10位志愿者的第10幅图像图像路径
path_2='C:\att_faces\Problem Set 3 att_faces\att_faces\s2\10.pgm';
path_3='C:\att_faces\Problem Set 3 att_faces\att_faces\s3\10.pgm';
path_4='C:\att_faces\Problem Set 3 att_faces\att_faces\s4\10.pgm';
path_5='C:\att_faces\Problem Set 3 att_faces\att_faces\s5\10.pgm';
path_6='C:\att_faces\Problem Set 3 att_faces\att_faces\s6\10.pgm';
path_7='C:\att_faces\Problem Set 3 att_faces\att_faces\s7\10.pgm';
path_8='C:\att_faces\Problem Set 3 att_faces\att_faces\s8\10.pgm';
path_9='C:\att_faces\Problem Set 3 att_faces\att_faces\s9\10.pgm';
path_10='C:\att_faces\Problem Set 3 att_faces\att_faces\s10\10.pgm';

max_loss=0;
for i=1:10
    path1=eval(strcat('path_',num2str(i))); %图像路径组合
    test_1=imread(path1);
    re_1=reconstruction(path1,miu,unit_V ); %调用重构函数reconstruction
    test_1=reshape(test_1,10304,1);
    re_1=reshape(re_1,10304,1);
    x=double(test_1-re_1);
    loss=norm(x,2);     %计算2范数误差
    if loss>=max_loss
        max_loss=loss;
    end
end
display(max_loss);

threshold=1900; %设定阈值
path_t1='C:\att_faces\Problem Set 3 att_faces\att_faces\s31\1.pgm';%后10位志愿者图像路径，人脸识别测试
path_t2='C:\att_faces\Problem Set 3 att_faces\att_faces\s32\1.pgm';
path_t3='C:\att_faces\Problem Set 3 att_faces\att_faces\s33\1.pgm';
path_t4='C:\att_faces\Problem Set 3 att_faces\att_faces\s34\1.pgm';
path_t5='C:\att_faces\Problem Set 3 att_faces\att_faces\s35\1.pgm';
path_t6='C:\att_faces\Problem Set 3 att_faces\att_faces\s36\1.pgm';
path_t7='C:\att_faces\Problem Set 3 att_faces\att_faces\s37\1.pgm';
path_t8='C:\att_faces\Problem Set 3 att_faces\att_faces\s38\1.pgm';
path_t9='C:\att_faces\Problem Set 3 att_faces\att_faces\s39\1.pgm';
path_t10='C:\att_faces\Problem Set 3 att_faces\att_faces\s40\1.pgm';

maxloss=0;
for i=1:10
    path1=eval(strcat('path_t',num2str(i))); %测试用图片路径
    test_1=imread(path1);
    re_1=reconstruction(path1,miu,unit_V ); %调用重构函数reconstruction
    test_1=reshape(test_1,10304,1);
    re_1=reshape(re_1,10304,1);
    x=double(test_1-re_1);
    loss=norm(x,2);     %2范数误差
    if loss>threshold   %图像是否为人脸的简单判别
        display('not human face');
    else
        display('human face!');
    end
    if loss>maxloss
        maxloss=loss;
    end      
end

display(maxloss);


    



