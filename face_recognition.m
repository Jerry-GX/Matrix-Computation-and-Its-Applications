new_path='C:\att_faces\';   %240��ͼ��洢·��
newDir=dir(new_path);
count2=0; %������������ͳ�Ʋ�������ͼ��������count3ͬ
count3=0;
Z=double(zeros(10304,240)); %��ʼ�����ݾ���Z������240��ͼ��������
J=zeros(112,92);

%����240��������ƽ����
for i = 1:length(newDir)
    %ȥ�������ļ��к�Problem Set 3 att_faces�ļ���
    if(isequal(newDir(i).name,'.')||isequal(newDir(i).name,'..')||isequal(newDir(i).name,'Problem Set 3 att_faces'))                
    continue;
    end
    img_dir=dir([new_path newDir(i).name '\*.pgm']);
    for k =1:length(img_dir)                 % ��������ͼƬ
        I2 = double(imread([new_path newDir(i).name '\' img_dir(k).name]));
        J=J+I2;
        count2=count2+1;
    end
end
J=J/240;
%imshow(uint8(J));
miu=reshape(J,10304,1);  %��ֵ������

for i = 1:length(newDir)
    %ȥ�������ļ��к�Problem Set 3 att_faces�ļ���
    if(isequal(newDir(i).name,'.')||isequal(newDir(i).name,'..')||isequal(newDir(i).name,'Problem Set 3 att_faces'))                
    continue;
    end
    img_dir=dir([new_path newDir(i).name '\*.pgm']);
    for k =1:length(img_dir)                 % ��������ͼƬ
        I2 = double(imread([new_path newDir(i).name '\' img_dir(k).name]));
        I2=reshape(I2,10304,1); %ͼ�����������
        z=I2-miu;   %ȥ���Ļ�
        count3=count3+1;
        Z(:,count3)=z;     %�������ݾ���Z   
    end
end

%���ɷַ���PCA
C0=Z'*Z;
[V0,a]=eig(C0);  %����C0�����ֽ�
V=Z*V0;  %��������
sort_V=double(zeros(10304,240));
k=240;
for i=1:240  %����������������ֵ�Ӵ�С����
    sort_V(1:10304,i)=V(1:10304,k);
    k=k-1;    
end

new_sort_V=sort_V(1:10304,1:40); %��������40������ֵ��Ӧ����������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����Ϊ����ʶ�𲿷�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unit_V=double(zeros(10304,40));
for i=1:40
    unit_V(:,i)=new_sort_V(:,i)/norm(new_sort_V(:,i)); %����������һ��Ϊ��λ����
end

path_1='C:\att_faces\Problem Set 3 att_faces\att_faces\s1\10.pgm'; %ǰ10λ־Ը�ߵĵ�10��ͼ��ͼ��·��
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
    path1=eval(strcat('path_',num2str(i))); %ͼ��·�����
    test_1=imread(path1);
    re_1=reconstruction(path1,miu,unit_V ); %�����ع�����reconstruction
    test_1=reshape(test_1,10304,1);
    re_1=reshape(re_1,10304,1);
    x=double(test_1-re_1);
    loss=norm(x,2);     %����2�������
    if loss>=max_loss
        max_loss=loss;
    end
end
display(max_loss);

threshold=1900; %�趨��ֵ
path_t1='C:\att_faces\Problem Set 3 att_faces\att_faces\s31\1.pgm';%��10λ־Ը��ͼ��·��������ʶ�����
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
    path1=eval(strcat('path_t',num2str(i))); %������ͼƬ·��
    test_1=imread(path1);
    re_1=reconstruction(path1,miu,unit_V ); %�����ع�����reconstruction
    test_1=reshape(test_1,10304,1);
    re_1=reshape(re_1,10304,1);
    x=double(test_1-re_1);
    loss=norm(x,2);     %2�������
    if loss>threshold   %ͼ���Ƿ�Ϊ�����ļ��б�
        display('not human face');
    else
        display('human face!');
    end
    if loss>maxloss
        maxloss=loss;
    end      
end

display(maxloss);


    



