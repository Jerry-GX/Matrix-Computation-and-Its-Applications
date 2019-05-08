function [ y ] = reconstruction( path,miu,unit_V )
%reconstruction function
test_img=imread(path);
z1=double(reshape(test_img,10304,1));
z1=z1-miu;
y1=unit_V'*z1;
y=unit_V*y1+miu;
y=uint8((reshape(y,112,92)));
end
